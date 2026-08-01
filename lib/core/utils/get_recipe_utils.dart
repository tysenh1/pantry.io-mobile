import 'package:fuzzy/fuzzy.dart';
import 'package:pantry_io_mobile/domain/models/recipe_with_ingredients.dart';

bool isIngredientQuantitySufficient(IngredientItem ing) {
  return ing.pantryQuantity >= (ing.quantityNeeded * ing.gramWeight);
}

List<RecipeWithIngredients> filterCookableRecipes(
    List<RecipeWithIngredients> recipes
    ) {
  return recipes.where((recipe) {
    final requiredIngredients = recipe.ingredients
        .where((i) => !i.isOptional)
        .toList();

    return requiredIngredients.every(
          (ingredient) =>
      // ingredient.isStaple ||
      isIngredientQuantitySufficient(ingredient),
    );
  }).toList();
}

List<RecipeWithIngredients> filterRecipesByTags(
    List<RecipeWithIngredients> recipes,
    Set<String> tags
    ) {
  return recipes.where((recipe) {
    return tags.every((tag) => recipe.tags?.contains(tag) ?? false);
  }).toList();
}

List<RecipeWithIngredients> filterRecipesBySearchQuery(
  List<RecipeWithIngredients> recipes,
  String searchQuery
) {
  final fuse = Fuzzy<RecipeWithIngredients>(
    recipes,
    options: FuzzyOptions(
      keys: [
        WeightedKey(name: 'name', getter: (r) => r.name, weight: 1.0),
        // Uncomment this codeblock if you want tags to count in the fuzzy search
        // WeightedKey(
        //   name: 'tags',
        //   getter: (r) => r.tags ?? '',
        //   weight: 0.7,
        // ),
      ],
      threshold: 0.4,
    ),
  );

  final results = fuse.search(searchQuery);
  return results.map((r) => r.item).toList();
}