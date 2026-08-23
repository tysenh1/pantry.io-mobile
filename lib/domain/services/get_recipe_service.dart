import 'package:pantry_io_mobile/core/constants/get_recipe_sort_order.dart';
import 'package:pantry_io_mobile/core/utils/recipe_utils.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/recipe_history_with_ingredients.dart';
import 'package:pantry_io_mobile/domain/models/recipe_with_ingredients.dart';

class GetRecipeService {

  Future<void> cookRecipe(
      RecipeWithIngredients recipe,
      double multiplier,
      AppDatabase db
      ) async {
    await db.transaction(() async {
      for (final ingredient in recipe.ingredients) {
        final normalizedQuantity = (ingredient.quantityNeeded * ingredient.gramWeight) * multiplier;
        final roundedQuantity = (normalizedQuantity * 10).ceil() / 10;
        // final roundedQuantity = normalizedQuantity.ceil().toDouble();
        await db.pantryDao.subtractQuantity(roundedQuantity, ingredient.pantryId);

      }
      await db.recipeHistoryDao.insert(RecipeHistoryWithIngredients.fromRecipe(recipe, multiplier, DateTime.now()));
    });
  }

  List<RecipeWithIngredients> sortRecipes({
    required List<RecipeWithIngredients> recipes,
    GetRecipeSortOrder sortOrder = GetRecipeSortOrder.nameAsc
  }) {
    switch (sortOrder) {
      case GetRecipeSortOrder.nameAsc:
        recipes.sort((a, b) => a.name.compareTo(b.name));
      case GetRecipeSortOrder.nameDesc:
        recipes.sort((a, b) => b.name.compareTo(a.name));
    }

    return recipes;
  }

  List<RecipeWithIngredients> filterRecipes({
    required List<RecipeWithIngredients> recipes,
    String? searchQuery,
    Set<String>? selectedTags,
    bool? showIncompleteRecipes
  }) {
    if (showIncompleteRecipes == false) {
      recipes = filterCookableRecipes(recipes);
    }

    if (selectedTags != null && selectedTags.isNotEmpty) {
      recipes = filterRecipesByTags(recipes, selectedTags);
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      recipes = filterRecipesBySearchQuery(recipes, searchQuery);
    }

    return recipes;
  }

  List<RecipeWithIngredients> process({
    required List<RecipeWithIngredients> recipes,
    GetRecipeSortOrder sortOrder = GetRecipeSortOrder.nameAsc,
    String? searchQuery,
    Set<String>? selectedTags,
    bool? showIncompleteRecipes
  }) {
    recipes = filterRecipes(recipes: recipes, selectedTags: selectedTags, searchQuery: searchQuery, showIncompleteRecipes: showIncompleteRecipes);
    recipes = sortRecipes(recipes: recipes, sortOrder: sortOrder);

    return recipes;
  }
}