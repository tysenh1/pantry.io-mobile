const Map<String, double> conversionRates = {
  "lb": 453.59,
  "oz": 28.35,
  "fl_oz": 28.41,
  "kg": 1000.0,
  "l": 1000.0,
  "ml": 1.0,
  "g": 1.0,
  "pcs": 1.0,
};

double normalizeQuantity(
  double amount,
  String fromUnit, {
  String toUnit = 'g',
}) {
  final fromRate = conversionRates[fromUnit.toLowerCase()];
  final toRate = conversionRates[toUnit.toLowerCase()];

  if (fromRate == null || toRate == null) {
    return amount;
  }

  return (amount * fromRate) / toRate;
}
