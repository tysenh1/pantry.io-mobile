import 'package:pantry_io_mobile/core/utils/unit_converter.dart';

int subtractQuantity(
  int itemQuantity,
  String itemPrimaryUnit,
  double itemWeightPerPiece,
  double recipeQuantityNeeded,
  String recipeUnit,
) {
  if (itemPrimaryUnit == recipeUnit) {
    return (itemQuantity - recipeQuantityNeeded).floor();
  }

  if (recipeUnit == 'pcs' && itemPrimaryUnit != 'pcs') {
    double amountGrams = recipeQuantityNeeded * (itemWeightPerPiece);
    double subtractInPrimary = normalizeQuantity(
      amountGrams,
      'g',
      toUnit: itemPrimaryUnit,
    );

    return (itemQuantity - subtractInPrimary).floor();
  }

  if (recipeUnit != 'pcs' && itemPrimaryUnit == 'pcs') {
    double amountGrams = itemQuantity * itemWeightPerPiece;
    double amountToAdd = normalizeQuantity(recipeQuantityNeeded, recipeUnit);
    return ((amountGrams - amountToAdd) / itemWeightPerPiece).floor();
  }

  double subtractInPrimary = normalizeQuantity(
    recipeQuantityNeeded,
    recipeUnit,
    toUnit: itemPrimaryUnit,
  );
  return (itemQuantity - subtractInPrimary).floor();
}
