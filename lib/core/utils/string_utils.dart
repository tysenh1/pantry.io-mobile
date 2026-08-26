extension StringCapitalization on String {
  String toTitleCase() {
    return split(' ').map((word) =>
    word.isEmpty ? word : word[0].toUpperCase() + word.substring(1)).join(' ');
  }
}

String formatQuantity(double value) {
  if (value == value.roundToDouble()) {
    return value.toStringAsFixed(0);
  }

  final fixed = value.toStringAsFixed(2);
  return fixed.replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
}