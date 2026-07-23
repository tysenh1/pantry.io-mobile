import 'package:pantry_io_mobile/data/database/tables/recipe_history_table.dart';

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

  String get tagString => (tags == null || tags!.isEmpty)
      ? 'No tags'
      : tags!.join(', ');
}