import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
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

  bool _isIngredientQuantitySufficient(IngredientItem ing) {
    debugPrint("Recipe Name: ${ing.name}, quan: ${ing.quantityNeeded * ing.gramWeight}, pan quan: ${ing.pantryQuantity}");
    return ing.pantryQuantity >= (ing.quantityNeeded * ing.gramWeight);
  }

  List<RecipeWithIngredients> _filterCookableRecipes(
    List<RecipeWithIngredients> recipes
  ) {
    return recipes.where((recipe) {
      final requiredIngredients = recipe.ingredients
          .where((i) => !i.isOptional)
          .toList();
      debugPrint("recipe name: ${recipe.name}");

      return requiredIngredients.every(
          (ingredient) =>
              // ingredient.isStaple ||
              _isIngredientQuantitySufficient(ingredient),
      );
    }).toList();
  }

  List<RecipeWithIngredients> _filterRecipesByTags(
      List<RecipeWithIngredients> recipes,
      Set<String> tags
  ) {
    return recipes.where((recipe) {
      return tags.every((tag) => recipe.tags?.contains(tag) ?? false);
    }).toList();
  }

  Stream<List<RecipeWithIngredients>> watchAllRecipes({
    bool filterIncompleteRecipes = true,
    Set<String>? selectedTags,
  }) {
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
          if (!_isIngredientQuantitySufficient(recipeIngredient)) {
            recipeMap[recipe.id]!.isRecipeComplete = false;
          }
        } else {
          recipeMap[recipe.id] = RecipeWithIngredients(
              id: recipe.id,
              name: recipe.name,
              tags: Set<String>.from(jsonDecode(recipe.tags)),
              instructions: recipe.instructions,
              isRecipeComplete: _isIngredientQuantitySufficient(recipeIngredient),
              ingredients: [recipeIngredient]
          );
        }
      }



      List<RecipeWithIngredients> allRecipes = recipeMap.values.toList();

      if (filterIncompleteRecipes) {
        allRecipes = _filterCookableRecipes(allRecipes);
      }

      for (final row in allRecipes) {
        for (final ing in row.ingredients) {
          debugPrint("Recipe Name: ${row.name}, quan: ${ing.quantityNeeded * ing.gramWeight}, pan quan: ${ing.pantryQuantity}");
        }
      }

      if (selectedTags != null && selectedTags.isNotEmpty) {
        allRecipes = _filterRecipesByTags(allRecipes, selectedTags);
      }
      return allRecipes.map((recipe) => recipe).toList();
    });
  }
}
