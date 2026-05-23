

import 'package:pantry_io_mobile/domain/models/generic_name_info.dart';

class ItemInfo {
  final String barcode;
  final String productName;
  final GenericNameInfo? genericName;
  final double unitSize;
  final String unitType;

  const ItemInfo({
    required this.barcode,
    required this.productName,
    this.genericName,
    required this.unitSize,
    required this.unitType
  });
}