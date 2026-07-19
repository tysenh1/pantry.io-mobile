import 'dart:convert';

class RecipeWithIngredients {
  final int id;
  final String name;
  final Set<String>? tags;
  final String instructions;
  final List<IngredientItem> ingredients;
  bool isRecipeComplete;

  RecipeWithIngredients({
    required this.id,
    required this.name,
    this.tags,
    required this.instructions,
    required this.ingredients,
    required this.isRecipeComplete,
  });

  String get tagString => (tags == null || tags!.isEmpty)
    ? 'No tags'
    : tags!.join(', ');

//   List<String> get tagList => tags == null
//     ? []
//     : tags!
//       .split(',')
//       .map((t) => t.trim())
//       .where((t) => t.isNotEmpty)
//       .toList();
//
}

class IngredientItem {
  final int pantryId;
  final double quantityNeeded;
  final String ingredientUnit;
  final double pantryQuantity;
  final String pantryUnit;
  final bool isOptional;
  final bool isStaple;
  final String name;

  IngredientItem({
    required this.pantryId,
    required this.quantityNeeded,
    required this.ingredientUnit,
    required this.pantryQuantity,
    required this.pantryUnit,
    this.isOptional = false,
    this.isStaple = false,
    required this.name,
  });
}
