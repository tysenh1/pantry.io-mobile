import 'package:pantry_io_mobile/domain/models/consumed_ingredient.dart';

class RecipeHistoryWithIngredients {
  final int id;
  final int? recipeId;
  final String recipeName;
  final String instructions;
  final Set<String>? tags;
  final List<ConsumedIngredient> ingredientsConsumed;
  final double multiplier;
  final DateTime cookedAt;

  RecipeHistoryWithIngredients({
    required this.id,
    this.recipeId,
    required this.recipeName,
    required this.instructions,
    this.tags,
    required this.ingredientsConsumed,
    required this.multiplier,
    required this.cookedAt,
  });
}