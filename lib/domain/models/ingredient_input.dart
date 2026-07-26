import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';

class IngredientInput {
  int pantryId;
  int? genericNameId;
  String quantityNeeded;
  String? selectedUnit;
  int? selectedNameId;

  Set<String> availableUnits;

  final qtyController = TextEditingController();

  IngredientInput({
    this.pantryId = 0,
    this.genericNameId,
    this.quantityNeeded = '',
    this.selectedUnit,
    this.selectedNameId,
    Set<String>? availableUnits,
  }) : availableUnits = availableUnits ?? {};

  void dispose() {
    qtyController.dispose();
  }

  @override
  String toString() {
    return 'IngredientInput(qty: ${qtyController.text}, unit: ${selectedUnit}, pantryId: $pantryId, selectedIndex: $selectedNameId)';
  }

  RecipeIngredientsCompanion toCompanion(int recipeId) {
    return RecipeIngredientsCompanion.insert(
      recipeId: recipeId,
      pantryId: pantryId,
      quantityNeeded: double.tryParse(qtyController.text) ?? 0.0,
      unit: selectedUnit ?? '',
    );
  }
}
