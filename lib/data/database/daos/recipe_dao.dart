import 'package:drift/drift.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/data/database/tables/recipes_table.dart';
import 'package:pantry_io_mobile/data/database/tables/recipe_ingredients_table.dart';
import 'package:pantry_io_mobile/domain/models/browse_recipes_item.dart';
import 'package:pantry_io_mobile/core/utils/unit_converter.dart';

part 'recipe_dao.g.dart';

@DriftAccessor(tables: [Recipes, RecipeIngredients])
class RecipeDao extends DatabaseAccessor<AppDatabase> with _$RecipeDaoMixin {
  RecipeDao(AppDatabase db) : super(db);

  Future<void> createRecipe({
    required String name,
    required String instructions,
    String? rawTags,
    required List<RecipeIngredientsCompanion> ingredientCompanions,
  }) {
    return transaction(() async {
      final cleanedTags = rawTags?.trim().replaceAll(' ', '') ?? '';

      final recipeId = await into(recipes).insert(
        RecipesCompanion.insert(
          name: name,
          instructions: instructions,
          tags: cleanedTags,
        ),
      );

      for (var companion in ingredientCompanions) {
        await into(
          recipeIngredients,
        ).insert(companion.copyWith(recipeId: Value(recipeId)));
      }
    });
  }

  Stream<List<RecipeBrowseItem>> watchAllRecipes() {
    return customSelect(
      '''
      SELECT r.*,
        (SELECT json_group_array(
          json_object(
            'quantityNeeded', ri.quantity_needed,
            'ingredientUnit', ri.unit,
            'pantryQuantity', p.quantity,
            'primaryUnit', g.primary_unit
          )
        )
        FROM recipe_ingredients ri
        JOIN pantry p ON ri.pantry_id = p.id
        JOIN generic_names g ON p.generic_name_id = g.id
        WHERE ri.recipe_id = r.id) as ingredients
      FROM recipes r
      ''',
      readsFrom: {recipes, recipeIngredients, pantry, genericNames},
    ).watch().map((rows) {
      final recipesList = rows
          .map((row) => RecipeBrowseItem.fromRow(row))
          .toList();

      return filterCookableRecipes(recipesList);
    });
  }

  List<RecipeBrowseItem> filterCookableRecipes<T>(
    List<RecipeBrowseItem> recipes,
  ) {
    return recipes.where((recipe) {
      return recipe.ingredients.every((ing) {
        return normalizeQuantity(
              ing.pantryQuantity.toDouble(),
              ing.primaryUnit,
            ) >=
            normalizeQuantity(ing.quantityNeeded, ing.ingredientUnit);
      });
    }).toList();
  }
}
