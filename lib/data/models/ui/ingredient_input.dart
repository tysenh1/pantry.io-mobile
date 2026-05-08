import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';

class IngredientInput {
  String pantryId;
  int quantityNeeded;
  String unit;
  int? selectedNameIndex;

  final qtyController = TextEditingController();
  final unitController = TextEditingController();

  IngredientInput({
    this.pantryId = '',
    this.quantityNeeded = 0,
    this.unit = '',
  });

  void dispose() {
    qtyController.dispose();
    unitController.dispose();
  }

  @override
  String toString() {
    return 'IngredientInput(qty: ${qtyController.text}, unit: ${unitController.text}, pantryId: $pantryId, selectedIndex: $selectedNameIndex)';
  }

  RecipeIngredientsCompanion toCompanion(int recipeId) {
    return RecipeIngredientsCompanion.insert(
      recipeId: recipeId,
      pantryId: pantryId,
      quantityNeeded: int.tryParse(qtyController.text) ?? 0,
      unit: unitController.text,
    )
  }
}
