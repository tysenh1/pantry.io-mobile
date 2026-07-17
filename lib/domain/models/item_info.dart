

import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/generic_name_info.dart';

class ProductInfo {
  final int? id;
  final String barcode;
  final String productName;
  final GenericNameInfo? genericName;
  final double unitSize;
  final String unitType;

  const ProductInfo({
    this.id,
    required this.barcode,
    required this.productName,
    this.genericName,
    required this.unitSize,
    required this.unitType
  });

  ProductsCompanion toCompanion() {
    return ProductsCompanion.insert(
      barcode: barcode,
      productName: productName,
      genericNameId: genericName!.id,
      unitSize: unitSize,
      unitType: unitType
    );
  }
}