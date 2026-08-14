
import 'package:pantry_io_mobile/core/constants/unit_abbreviations.dart';

double normalizeIngredientQuantity(
  double amount,
  double rate
) {

  return amount * rate;
}


String standardizeUnit(String raw) {
  return unitAbbreviations[raw.toLowerCase()] ?? raw;
}