import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/local_unit.dart';

class ScannerScreenFormModel {
  final barcodeController = TextEditingController();
  final nameController = TextEditingController();
  final unitSizeController = TextEditingController();
  int? selectedGenericId;
  int? selectedUnitId;
  
  PantryCompanion? getPantryCompanion(LocalUnit unit) {
    return PantryCompanion.insert(genericNameId: selectedGenericId!, quantity: Value(double.parse(unitSizeController.text)), unit: unit.name.toLowerCase());
  }

  ProductsCompanion? getProductCompanion(LocalUnit unit) {
    return ProductsCompanion.insert(
      barcode: barcodeController.text,
      productName: nameController.text,
      genericNameId: selectedGenericId!,
      unitSize: double.parse(unitSizeController.text),
      unitType: unit.name.toLowerCase()
    );
  }

  bool isValid() {
    if (barcodeController.text.trim().isEmpty) return false;
    if (nameController.text.trim().isEmpty) return false;
    if (unitSizeController.text.trim().isEmpty) return false;
    if (selectedGenericId == null) return false;
    if (selectedUnitId == null) return false;

    return true;
  }

  void dispose() {
    barcodeController.dispose();
    nameController.dispose();
    unitSizeController.dispose();
  }

  void reset() {
    barcodeController.text = '';
    nameController.text = '';
    unitSizeController.text = '';
    selectedUnitId = null;
    selectedGenericId = null;
  }
}