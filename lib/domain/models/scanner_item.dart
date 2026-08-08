import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/local_unit.dart';

class ScannerItem {
  final ProductsCompanion product;
  final LocalUnit ingredientUnit;

  const ScannerItem({
    required this.product,
    required this.ingredientUnit,
  });
}