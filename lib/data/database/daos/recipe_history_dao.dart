import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:pantry_io_mobile/core/constants/get_recipe_sort_order.dart';
import 'package:pantry_io_mobile/core/constants/recipe_history_sort_order.dart';
import 'package:pantry_io_mobile/data/database/tables/recipe_history_table.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/recipe_history_with_ingredients.dart';

part 'recipe_history_dao.g.dart';

@DriftAccessor(tables: [RecipeHistory])
class RecipeHistoryDao extends DatabaseAccessor<AppDatabase> with _$RecipeHistoryDaoMixin {
  RecipeHistoryDao(super.db);

  List<RecipeHistoryWithIngredients> _filterRecipesByTags(
      List<RecipeHistoryWithIngredients> recipes,
      Set<String> tags,
      ) {
    return recipes.where((recipe) {
      return tags.every((tag) => recipe.tags?.contains(tag) ?? false);
    }).toList();
  }

  Stream<List<RecipeHistoryWithIngredients>> watchAllRecipes({
    Set<String>? selectedTags,
    RecipeHistorySortOrder sortOrder = RecipeHistorySortOrder.dateDesc
  }) {
    return (select(recipeHistory)..orderBy([(t) => OrderingTerm.desc(t.cookedAt)])).watch().map((rows) {
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

      switch (sortOrder) {
        case RecipeHistorySortOrder.dateAsc:
          recipeHistoryList.sort((a, b) => a.cookedAt.compareTo(b.cookedAt));
        case RecipeHistorySortOrder.dateDesc:
          recipeHistoryList.sort((a, b) => b.cookedAt.compareTo(a.cookedAt));
      }

      return recipeHistoryList;
    });
  }

  Future<void> insert(RecipeHistoryWithIngredients recipe) async {
    await into(recipeHistory).insert(
      RecipeHistoryCompanion.insert(
        recipeId: Value(recipe.recipeId),
        name: recipe.name,
        instructions: recipe.instructions,
        tags: Value(jsonEncode(recipe.tags?.toList() ?? [])),
        ingredientsConsumed: recipe.ingredientsConsumed,
        multiplier: Value(recipe.multiplier),
        cookedAt: recipe.cookedAt
      )
    );
  }
}