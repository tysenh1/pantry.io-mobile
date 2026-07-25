import 'package:pantry_io_mobile/data/database/tables/recipe_history_table.dart';
import 'package:pantry_io_mobile/domain/models/recipe_with_ingredients.dart';

class RecipeHistoryWithIngredients {
  final int id;
  final int? recipeId;
  final String name;
  final String instructions;
  final Set<String>? tags;
  final List<ConsumedIngredient> ingredientsConsumed;
  final double multiplier;
  final DateTime cookedAt;

  RecipeHistoryWithIngredients({
    required this.id,
    this.recipeId,
    required this.name,
    required this.instructions,
    this.tags,
    required this.ingredientsConsumed,
    required this.multiplier,
    required this.cookedAt,
  });

  String get formattedTagString => (tags == null || tags!.isEmpty)
      ? 'No tags'
      : tags!.join(', ');

  String get tagString => (tags == null || tags!.isEmpty)
      ? ''
      : tags!.join(', ');

  factory RecipeHistoryWithIngredients.fromRecipe(
    RecipeWithIngredients recipe,
    double multiplier,
    DateTime cookedAt
  ) {
    return RecipeHistoryWithIngredients(
      id: 0,
      recipeId: recipe.id,
      name: recipe.name,
      instructions: recipe.instructions,
      tags: recipe.tags,
      ingredientsConsumed: recipe.ingredients.map((ing) => ConsumedIngredient(name: ing.name, quantity: ing.quantityNeeded * multiplier, unit: ing.ingredientUnit)).toList(),
      multiplier: multiplier,
      cookedAt: cookedAt,
    );
  }
}

