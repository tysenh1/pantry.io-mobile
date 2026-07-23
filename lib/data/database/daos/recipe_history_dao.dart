import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:pantry_io_mobile/data/database/tables/recipe_history_table.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/recipe_history_with_ingredients.dart';

part 'recipe_history_dao.g.dart';

@DriftAccessor(tables: [RecipeHistory])
class RecipeHistoryDao extends DatabaseAccessor<AppDatabase> with _$RecipeHistoryDaoMixin {
  RecipeHistoryDao(super.db);

  List<RecipeHistoryWithIngredients> _filterRecipesByTags(
      List<RecipeHistoryWithIngredients> recipes,
      Set<String> tags
      ) {
    return recipes.where((recipe) {
      return tags.every((tag) => recipe.tags?.contains(tag) ?? false);
    }).toList();
  }

  Stream<List<RecipeHistoryWithIngredients>> watchAllRecipes({
    Set<String>? selectedTags,
  }) {
    return select(recipeHistory).watch().map((rows) {
      List<RecipeHistoryWithIngredients> recipeHistoryList = [];

      for (final recipe in rows) {

        recipeHistoryList.add(RecipeHistoryWithIngredients(
            id: recipe.id,
            recipeId: recipe.recipeId,
            name: recipe.name,
            instructions: recipe.instructions,
            tags: recipe.tags != null
                ? Set<String>.from(jsonDecode(recipe.tags!))
                : null,
            ingredientsConsumed: List<ConsumedIngredient>.from(
                recipe.ingredientsConsumed),
            multiplier: recipe.multiplier,
            cookedAt: recipe.cookedAt
        ));
      }

      if (selectedTags != null && selectedTags.isNotEmpty) {
        recipeHistoryList =
            _filterRecipesByTags(recipeHistoryList, selectedTags);
      }

      return recipeHistoryList;
    });
  }
}