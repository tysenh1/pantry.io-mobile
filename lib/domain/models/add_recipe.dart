import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'ingredient_input.dart';

class RecipeFormModel {
  final nameController = TextEditingController();
  final instructionsController = TextEditingController();
  final tagsController = TextEditingController();
  Set<String> tags = {};

  List<IngredientInput> ingredients = [IngredientInput()];

  List<RecipeIngredientsCompanion> getIngredientCompanions() {
    return ingredients.map((ing) {
      return RecipeIngredientsCompanion.insert(
        recipeId: -1,
        pantryId: ing.pantryId,
        quantityNeeded: double.tryParse(ing.qtyController.text.trim()) ?? 0.0,
        unit: ing.selectedUnit ?? '',
      );
    }).toList();
  }

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
      if (
        ing.pantryId == 0 ||
        ing.qtyController.text.trim().isEmpty ||
        ing.selectedUnit == null ||
        ing.selectedUnit!.isEmpty
      ) {
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
