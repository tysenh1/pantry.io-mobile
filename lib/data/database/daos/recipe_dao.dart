import 'package:drift/drift.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/data/database/tables/recipes_table.dart';
import 'package:pantry_io_mobile/data/database/tables/recipe_ingredients_table.dart';
import 'package:pantry_io_mobile/core/utils/unit_converter.dart';
import 'package:pantry_io_mobile/domain/models/recipe_with_ingredients.dart';

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

  List<RecipeWithIngredients> _filterCookableRecipes(
    List<RecipeWithIngredients> recipes
  ) {
    return recipes.where((recipe) {
      final requiredIngredients = recipe.ingredients
          .where((i) => !i.isOptional)
          .toList();

      return requiredIngredients.every(
          (ingredient) =>
              ingredient.isStaple ||
              ingredient.pantryQuantity >= ingredient.quantityNeeded,
      );
    }).toList();
  }

  Stream<List<RecipeWithIngredients>> watchAllRecipes({bool filter = false}) {
    final query = select(recipes).join([
      innerJoin(recipeIngredients, recipeIngredients.recipeId.equalsExp(recipes.id)),
      innerJoin(pantry, pantry.id.equalsExp(recipeIngredients.recipeId)),
      innerJoin(genericNames, genericNames.id.equalsExp(pantry.genericNameId)),
    ]);

    return query.watch().map((rows) {
      final Map<int, RecipeWithIngredients> recipeMap = {};

      for (final row in rows) {
        final recipe = row.readTable(recipes);
        final ingredient = row.readTable(recipeIngredients);
        final pantryRow = row.readTable(pantry);
        final genericName = row.readTable(genericNames);

        final recipeIngredient = IngredientItem(
          quantityNeeded: ingredient.quantityNeeded,
          ingredientUnit: ingredient.unit,
          pantryQuantity: pantryRow.quantity,
          primaryUnit: genericName.primaryUnit,
          isOptional: ingredient.optional,
          isStaple: pantryRow.isStaple
        );

        if (recipeMap.containsKey(recipe.id)) {
          recipeMap[recipe.id]!.ingredients.add(recipeIngredient);
        } else {
          recipeMap[recipe.id] = RecipeWithIngredients(
            id: recipe.id,
            name: recipe.name,
            tags: recipe.tags,
            instructions: recipe.instructions,
            ingredients: [recipeIngredient]
          );
        }
      }

      final allRecipes = recipeMap.values.toList();
      return _filterCookableRecipes(allRecipes);
    });
  }

  // Stream<List<BrowseRecipeItem>> watchAllRecipes() {
  //   return customSelect(
  //     '''
  //     SELECT r.*,
  //       (SELECT json_group_array(
  //         json_object(
  //           'quantityNeeded', ri.quantity_needed,
  //           'ingredientUnit', ri.unit,
  //           'pantryQuantity', p.quantity,
  //           'primaryUnit', g.primary_unit
  //         )
  //       )
  //       FROM recipe_ingredients ri
  //       JOIN pantry p ON ri.pantry_id = p.id
  //       JOIN generic_names g ON p.generic_name_id = g.id
  //       WHERE ri.recipe_id = r.id) as ingredients
  //     FROM recipes r
  //     ''',
  //     readsFrom: {recipes, recipeIngredients, pantry, genericNames},
  //   ).watch().map((rows) {
  //     final recipesList = rows
  //         .map((row) => BrowseRecipeItem.fromRow(row))
  //         .toList();
  //
  //     return filterCookableRecipes(recipesList);
  //   });
  // }

  Stream<List<TypedResult>> watchCookableRecipes({bool filter = false}) {
    final query = select(recipes).join([
      innerJoin(recipeIngredients, recipeIngredients.recipeId.equalsExp(recipes.id)),
      innerJoin(pantry, pantry.id.equalsExp(recipeIngredients.pantryId)),
      innerJoin(genericNames, genericNames.id.equalsExp(pantry.genericNameId)),
    ]);

    return query.watch();
  }

  // List<BrowseRecipeItem> filterCookableRecipes<T>(
  //   List<BrowseRecipeItem> recipes,
  // ) {
  //   return recipes.where((recipe) {
  //     return recipe.ingredients
  //   })
  // }
    // return recipes.where((recipe) {
    //   return recipe.ingredients.every((ing) {
    //     return normalizeQuantity(
    //           ing.pantryQuantity.toDouble(),
    //           ing.primaryUnit,
    //         ) >=
    //         normalizeQuantity(ing.quantityNeeded, ing.ingredientUnit);
    //   });
    // }).toList();
  // }
}
