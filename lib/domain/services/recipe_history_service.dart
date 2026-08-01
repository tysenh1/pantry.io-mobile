import 'package:pantry_io_mobile/core/constants/recipe_history_sort_order.dart';
import 'package:pantry_io_mobile/core/utils/history_utils.dart';
import 'package:pantry_io_mobile/domain/models/recipe_history_with_ingredients.dart';

class RecipeHistoryService {
  RecipeHistoryService();

  List<RecipeHistoryWithIngredients> sortRecipeHistory({
    required List<RecipeHistoryWithIngredients> recipes,
    RecipeHistorySortOrder sortOrder = RecipeHistorySortOrder.dateDesc
  }) {
    switch (sortOrder) {
      case RecipeHistorySortOrder.dateAsc:
        recipes.sort((a, b) => a.cookedAt.compareTo(b.cookedAt));
      case RecipeHistorySortOrder.dateDesc:
        recipes.sort((a, b) => b.cookedAt.compareTo(a.cookedAt));
    }

    return recipes;
  }

  List<RecipeHistoryWithIngredients> filterRecipeHistory({
    required List<RecipeHistoryWithIngredients> recipes,
    String? searchQuery,
    Set<String>? selectedTags,
  }) {
    if (selectedTags != null && selectedTags.isNotEmpty) {
      recipes = filterRecipeHistoryByTags(recipes, selectedTags);
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      recipes = filterRecipeHistoryBySearchQuery(recipes, searchQuery);
    }

    return recipes;
  }

  List<RecipeHistoryWithIngredients> process({
    required List<RecipeHistoryWithIngredients> recipes,
    RecipeHistorySortOrder sortOrder = RecipeHistorySortOrder.dateDesc,
    String? searchQuery,
    Set<String>? selectedTags,
  }) {
    recipes = filterRecipeHistory(recipes: recipes, searchQuery: searchQuery, selectedTags: selectedTags);
    recipes = sortRecipeHistory(recipes: recipes, sortOrder: sortOrder);

    return recipes;
  }
}