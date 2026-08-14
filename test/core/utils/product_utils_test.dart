import 'package:flutter_test/flutter_test.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:pantry_io_mobile/core/utils/product_utils.dart';

void main() {
  ProductResultV3 productResult = ProductResultV3();

  group('parseQuantity tests', () {
    test('returns parsed double from valid quantity string', () {
      final product = Product(quantity: '500 g');
      productResult.product = product;

      final result = parseQuantity(productResult);

      expect(result, 500.0);
    });

    test('returns parsed decimal from valid quantity string', () {
      final product = Product(quantity: '1.5 litres', packagingQuantity: null);
      productResult.product = product;

      final result = parseQuantity(productResult);

      expect(result, 1.5);
    });

    test('returns packagingQuantity when quantity is null', () {
      final product = Product(quantity: null, packagingQuantity: 250.0);
      productResult.product = product;

      final result = parseQuantity(productResult);

      expect(result, 250.0);
    });

    test('returns packagingQuantity when quantity is an empty string', () {
      final product = Product(quantity: '', packagingQuantity: 300.0);
      productResult.product = product;

      final result = parseQuantity(productResult);

      expect(result, 300.0);
    });

    test('returns 0.0 when regex fails to find a number in quantity', () {
      final product = Product(quantity: 'some invalid quantity', packagingQuantity: 250.0);
      productResult.product = product;

      final result = parseQuantity(productResult);

      expect(result, 0.0);
    });

    test('returns 0.0 when product is entirely null', () {
      productResult.product = null;

      final result = parseQuantity(productResult);

      expect(result, 0.0);
    });

    test('returns 0.0 when all quantity fields are null or 0.0', () {
      final product = Product(quantity: null, packagingQuantity: 0.0);
      productResult.product = product;

      final result = parseQuantity(productResult);

      expect(result, 0.0);
    });
  });

  group('parseUnit tests', () {
    test('returns parsed unit from valid quantity string', () {
      final product = Product(quantity: '500 g',);
      productResult.product = product;

      final result = parseUnit(productResult);

      expect(result, 'g');
    });

    test('returns first unit from invalid quantity', () {
      final product = Product(quantity: '500 g oz lbs');
      productResult.product = product;

      final result = parseUnit(productResult);

      expect(result, 'g');
    });

    test('returns empty string when no unit is given', () {
      final product = Product(quantity: '500');
      productResult.product = product;

      final result = parseUnit(productResult);

      expect(result, '');
    });

    test('returns an empty string when quantity is null', () {
      final product = Product(quantity: null);
      productResult.product = product;

      final result = parseUnit(productResult);

      expect(result, '');
    });

    test('returns an empty string when product is null', () {
      productResult.product = null;

      final result = parseUnit(productResult);

      expect(result, '');
    });
  });
}