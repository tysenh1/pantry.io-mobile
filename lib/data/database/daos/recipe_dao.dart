import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:pantry_io_mobile/core/utils/get_recipe_utils.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/data/database/tables/recipes_table.dart';
import 'package:pantry_io_mobile/data/database/tables/recipe_ingredients_table.dart';
import 'package:pantry_io_mobile/data/database/tables/ingredient_conversions_table.dart';
import 'package:pantry_io_mobile/domain/models/recipe_with_ingredients.dart';

part 'recipe_dao.g.dart';

@DriftAccessor(tables: [Recipes, RecipeIngredients, IngredientConversions])
class RecipeDao extends DatabaseAccessor<AppDatabase> with _$RecipeDaoMixin {
  RecipeDao(super.db);

  Future<void> createRecipe({
    required String name,
    required String instructions,
    Set<String>? tags,
    required List<RecipeIngredientsCompanion> ingredientCompanions,
  }) {
    return transaction(() async {
      final recipeId = await into(recipes).insert(
        RecipesCompanion.insert(
          name: name,
          instructions: instructions,
          tags: jsonEncode(tags?.toList() ?? []),
        ),
      );

      for (var companion in ingredientCompanions) {
        await into(
          recipeIngredients,
        ).insert(companion.copyWith(recipeId: Value(recipeId)));
      }
    });
  }

  Stream<List<RecipeWithIngredients>> watchAllRecipes() {
    final query = select(recipes).join([
      innerJoin(recipeIngredients, recipeIngredients.recipeId.equalsExp(recipes.id)),
      innerJoin(pantry, pantry.id.equalsExp(recipeIngredients.pantryId)),
      innerJoin(genericNames, genericNames.id.equalsExp(pantry.genericNameId)),
      leftOuterJoin(ingredientConversions,
          ingredientConversions.genericNameId.equalsExp(genericNames.id) &
          recipeIngredients.unit.equalsExp(ingredientConversions.unit)
      )
    ]);

    return query.watch().map((rows) {
      final Map<int, RecipeWithIngredients> recipeMap = {};

      for (final row in rows) {
        final recipe = row.readTable(recipes);
        final ingredient = row.readTable(recipeIngredients);
        final pantryRow = row.readTable(pantry);
        final genericName = row.readTable(genericNames);
        final conversion = row.readTableOrNull(ingredientConversions);



        final recipeIngredient = IngredientItem(
          pantryId: ingredient.pantryId,
          quantityNeeded: ingredient.quantityNeeded,
          ingredientUnit: ingredient.unit,
          pantryQuantity: pantryRow.quantity,
          pantryUnit: genericName.primaryUnit,
          isOptional: ingredient.optional,
          isStaple: pantryRow.isStaple,
          name: genericName.name,
          gramWeight: (conversion != null) ? conversion.gramWeight : 1,
          genericNameId: genericName.id
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
              tags: Set<String>.from(jsonDecode(recipe.tags)),
              instructions: recipe.instructions,
              isRecipeComplete: isIngredientQuantitySufficient(recipeIngredient),
              ingredients: [recipeIngredient]
          );
        }
      }

      return recipeMap.values.toList();
    });
  }
}
