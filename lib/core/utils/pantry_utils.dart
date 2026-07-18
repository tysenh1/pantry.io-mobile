import 'package:pantry_io_mobile/core/utils/unit_converter.dart';

int subtractQuantity(
  double productQuantity,
  String productPrimaryUnit,
  double itemWeightPerPiece,
  double recipeQuantityNeeded,
  String recipeUnit,
) {
  if (productPrimaryUnit == recipeUnit) {
    return (productQuantity - recipeQuantityNeeded).floor();
  }

  if (recipeUnit == 'pcs' && productPrimaryUnit != 'pcs') {
    double amountGrams = recipeQuantityNeeded * (itemWeightPerPiece);
    double subtractInPrimary = normalizeQuantity(
      amountGrams,
      'g',
      toUnit: productPrimaryUnit,
    );

    return (productQuantity - subtractInPrimary).floor();
  }

  if (recipeUnit != 'pcs' && productPrimaryUnit == 'pcs') {
    double amountGrams = productQuantity * itemWeightPerPiece;
    double amountToAdd = normalizeQuantity(recipeQuantityNeeded, recipeUnit);
    return ((amountGrams - amountToAdd) / itemWeightPerPiece).floor();
  }

  double subtractInPrimary = normalizeQuantity(
    recipeQuantityNeeded,
    recipeUnit,
    toUnit: productPrimaryUnit,
  );
  return (productQuantity - subtractInPrimary).floor();
}
