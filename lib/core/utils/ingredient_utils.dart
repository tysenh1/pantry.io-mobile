import 'package:pantry_io_mobile/core/utils/unit_converter.dart';
import 'package:pantry_io_mobile/domain/models/recipe_with_ingredients.dart';

bool isIngredientQuantitySufficient(IngredientItem ingredient, [double multiplier = 1.0]) {
  return normalizeQuantity(ingredient.pantryQuantity, ingredient.pantryUnit) >= normalizeQuantity((ingredient.quantityNeeded * multiplier), ingredient.ingredientUnit);
}