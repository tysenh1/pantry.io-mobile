import 'package:pantry_io_mobile/core/utils/unit_converter.dart';
import 'package:pantry_io_mobile/domain/models/recipe_with_ingredients.dart';

bool isIngredientQuantitySufficient(IngredientItem ingredient, [double multiplier = 1.0]) {
  return normalizeQuantity(ingredient.pantryQuantity, ingredient.pantryUnit) >= normalizeQuantity((ingredient.quantityNeeded * multiplier), ingredient.ingredientUnit);
}

// double subtractIngredientQuantity(IngredientItem ingredient) {
//   if (ingredient.ingredientUnit == ingredient.pantryUnit) {
//     return ingredient.pantryQuantity - ingredient.quantityNeeded;
//   }
//
//   if (ingredient.pantryUnit == 'pcs' && ingredient.ingredientUnit != 'pcs') {
//     double amountGrams = ingredient.pantryQuantity * ingredient.weightPerPiece!;
//     return (normalizeQuantity(amountGrams, 'g', toUnit: ingredient.ingredientUnit));
//   }
//
//   if (ingredient.pantryUnit != 'pcs' && ingredient.ingredientUnit == 'pcs') {
//     const amountGrams =
//   }
// }