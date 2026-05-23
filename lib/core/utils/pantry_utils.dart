import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:pantry_io_mobile/core/utils/unit_converter.dart';

final UNIT_REGEX = RegExp(r'([0-9.]+)\s*([a-zA-Z]+)');

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

double parseQuantity(ProductResultV3 result) {
  double finalQuantity = 0.0;
  if (result.product?.quantity != null && result.product?.quantity != '') {
    final regexArray = UNIT_REGEX.firstMatch(result.product?.quantity as String);
    if (regexArray == null) {
      return finalQuantity;
    }
    finalQuantity = double.tryParse(regexArray.group(1).toString()) ?? 0.0;
  } else if (result.product?.packagingQuantity != null && result.product?.packagingQuantity != 0.0) {
    finalQuantity = result.product?.packagingQuantity as double;
  }

  return finalQuantity;
}

String parseUnit(ProductResultV3 result) {
  // String finalUnit = '';
  if (result.product?.quantity != null && result.product?.quantity != '') {
    final regexArray = UNIT_REGEX.firstMatch(result.product?.quantity as String);
    return regexArray?.group(2).toString() ?? '';
  }

  return '';
}