import 'package:drift/drift.dart';
import 'package:pantry_io_mobile/core/utils/ingredient_utils.dart';
import 'package:pantry_io_mobile/core/utils/unit_converter.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/data/database/tables/recipes_table.dart';
import 'package:pantry_io_mobile/data/database/tables/recipe_ingredients_table.dart';
import 'package:pantry_io_mobile/domain/models/recipe_with_ingredients.dart';

part 'recipe_dao.g.dart';

@DriftAccessor(tables: [Recipes, RecipeIngredients])
class RecipeDao extends DatabaseAccessor<AppDatabase> with _$RecipeDaoMixin {
  RecipeDao(super.db);

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
              isIngredientQuantitySufficient(ingredient),
      );
    }).toList();
  }

  Stream<List<RecipeWithIngredients>> watchAllRecipes(
      bool filterIncompleteRecipes
  ) {
    final query = select(recipes).join([
      innerJoin(recipeIngredients, recipeIngredients.recipeId.equalsExp(recipes.id)),
      innerJoin(pantry, pantry.id.equalsExp(recipeIngredients.pantryId)),
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
          pantryId: ingredient.pantryId,
          quantityNeeded: ingredient.quantityNeeded,
          ingredientUnit: ingredient.unit,
          pantryQuantity: pantryRow.quantity,
          pantryUnit: genericName.primaryUnit,
          isOptional: ingredient.optional,
          isStaple: pantryRow.isStaple,
          name: genericName.name,
        );

        if (recipeMap.containsKey(recipe.id)) {
          recipeMap[recipe.id]!.ingredients.add(recipeIngredient);
          if (!isIngredientQuantitySufficient(recipeIngredient)) {
            recipeMap[recipe.id]!.isRecipeComplete = false;
          }
        } else {
          recipeMap[recipe.id] = RecipeWithIngredients(
            id: recipe.id,
            name: recipe.name,
            tags: recipe.tags,
            instructions: recipe.instructions,
            isRecipeComplete: isIngredientQuantitySufficient(recipeIngredient),
            ingredients: [recipeIngredient]
          );
        }
      }

      final allRecipes = recipeMap.values.toList();

      if (filterIncompleteRecipes) {
        return _filterCookableRecipes(allRecipes);
      }
      return allRecipes;
    });
  }
}
