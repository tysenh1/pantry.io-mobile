import 'package:flutter_test/flutter_test.dart';
import 'package:pantry_io_mobile/domain/models/scanner_screen_form.dart';

void main() {
  late ScannerScreenFormModel model;

  setUp(() {
    model = ScannerScreenFormModel();
  });
  group('isValid tests', () {
    test('returns true when all fields have valid info', () {
      model.barcodeController.text = 'barcode';
      model.nameController.text = 'name';
      model.unitSizeController.text = 'unit';
      model.selectedGenericId = 1;
      model.selectedUnitId = 1;

      final result = model.isValid();

      expect(result, isTrue);
    });

    test('returns false when barcode is empty', () {
      model.barcodeController.text = '';
      model.nameController.text = 'name';
      model.unitSizeController.text = 'unit';
      model.selectedGenericId = 1;
      model.selectedUnitId = 1;

      final result = model.isValid();

      expect(result, isFalse);
    });

    test('returns false when name is empty', () {
      model.barcodeController.text = 'barcode';
      model.nameController.text = '';
      model.unitSizeController.text = 'unit';
      model.selectedGenericId = 1;
      model.selectedUnitId = 1;

      final result = model.isValid();

      expect(result, isFalse);
    });

    test('returns false when unit is empty', () {
      model.barcodeController.text = 'barcode';
      model.nameController.text = 'name';
      model.unitSizeController.text = '';
      model.selectedGenericId = 1;
      model.selectedUnitId = 1;

      final result = model.isValid();

      expect(result, isFalse);
    });

    test('returns false when selected generic id is empty', () {
      model.barcodeController.text = 'barcode';
      model.nameController.text = 'name';
      model.unitSizeController.text = 'unit';
      model.selectedUnitId = 1;

      final result = model.isValid();

      expect(result, isFalse);
    });

    test('returns false when selected unit is empty', () {
      model.barcodeController.text = 'barcode';
      model.nameController.text = 'name';
      model.unitSizeController.text = 'unit';
      model.selectedGenericId = 1;

      final result = model.isValid();

      expect(result, isFalse);
    });
  });
}