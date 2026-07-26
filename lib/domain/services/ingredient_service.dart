import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/recipe_with_ingredients.dart';

Future<bool> isIngredientQuantitySufficient(IngredientItem ing, BuildContext context, [double multiplier = 1.0]) async {
  final db = context.read<AppDatabase>();
  final itemWeight = await db.ingredientConversionsDao.getConversionWeight(ing.genericNameId, ing.ingredientUnit);

  if (ing.pantryQuantity >= itemWeight) {
    return true;
  }

  return false;
}