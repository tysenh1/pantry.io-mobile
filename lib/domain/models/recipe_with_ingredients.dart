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

  String get formattedTagString => (tags == null || tags!.isEmpty)
    ? 'No tags'
    : tags!.join(', ');

  String get tagString => (tags == null || tags!.isEmpty)
      ? ''
      : tags!.join(', ');

  RecipeWithIngredients copyWith({
    int? id,
    String? name,
    Set<String>? tags,
    String? instructions,
    List<IngredientItem>? ingredients,
    bool? isRecipeComplete
  }) {
    return RecipeWithIngredients(
        id: id ?? this.id,
        name: name ?? this.name,
        tags: tags ?? this.tags,
        instructions: instructions ?? this.instructions,
        ingredients: ingredients ?? this.ingredients,
        isRecipeComplete: isRecipeComplete ?? this.isRecipeComplete
    );
  }
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
  final double? weightPerPiece;

  IngredientItem({
    required this.pantryId,
    required this.quantityNeeded,
    required this.ingredientUnit,
    required this.pantryQuantity,
    required this.pantryUnit,
    this.isOptional = false,
    this.isStaple = false,
    required this.name,
    this.weightPerPiece
  });
}
