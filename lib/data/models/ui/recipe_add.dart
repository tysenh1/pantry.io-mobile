import 'package:flutter/material.dart';
import 'ingredient_input.dart';

class RecipeFormModel {
  final nameController = TextEditingController();
  final instructionsController = TextEditingController();
  final tagsController = TextEditingController();

  List<IngredientInput> ingredients = [];

  void addIngredient() {
    ingredients.add(IngredientInput());
  }

  void removeIngredient(int index) {
    if (index >= 0 && index < ingredients.length) {
      ingredients[index].dispose();
      ingredients.removeAt(index);
    }
  }

  bool isValid() {
    if (nameController.text.trim().isEmpty) return false;
    if (instructionsController.text.trim().isEmpty) return false;
    if (ingredients.isEmpty) return false;

    for (var ing in ingredients) {
      if (ing.pantryId.isEmpty || ing.qtyController.text.trim().isEmpty) {
        return false;
      }
    }
    return true;
  }

  void dispose() {
    nameController.dispose();
    instructionsController.dispose();
    tagsController.dispose();
    for (var ing in ingredients) {
      ing.dispose();
    }
  }
}
