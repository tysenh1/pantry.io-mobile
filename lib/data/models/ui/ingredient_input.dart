import 'package:flutter/material.dart';

class IngredientInput {
  String recipeId;
  String pantryId;
  int quantityNeeded;
  String unit;
  int? selectedNameIndex;

  final qtyController = TextEditingController();
  final unitController = TextEditingController();

  IngredientInput({
    this.recipeId = '',
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
    return 'IngredientInput(qty: ${qtyController.text}, unit: ${unitController.text}, pantryId: $pantryId, recipeId: $recipeId, selectedIndex: $selectedNameIndex)';
  }
}
