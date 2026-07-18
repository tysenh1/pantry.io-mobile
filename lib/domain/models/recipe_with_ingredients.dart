import 'dart:convert';

class RecipeWithIngredients {
  final int id;
  final String name;
  final String? tags;
  final String instructions;
  final List<IngredientItem> ingredients;

  RecipeWithIngredients({
    required this.id,
    required this.name,
    this.tags,
    required this.instructions,
    required this.ingredients,
  });

  List<String> get tagList => tags == null
    ? []
    : tags!
      .split(',')
      .map((t) => t.trim())
      .where((t) => t.isNotEmpty)
      .toList();

}

class IngredientItem {
  final int pantryId;
  final double quantityNeeded;
  final String ingredientUnit;
  final double pantryQuantity;
  final String primaryUnit;
  final bool isOptional;
  final bool isStaple;
  final String name;

  IngredientItem({
    required this.pantryId,
    required this.quantityNeeded,
    required this.ingredientUnit,
    required this.pantryQuantity,
    required this.primaryUnit,
    this.isOptional = false,
    this.isStaple = false,
    required this.name,
  });
}
