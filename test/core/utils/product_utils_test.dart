import 'package:flutter_test/flutter_test.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:pantry_io_mobile/core/utils/product_utils.dart';
import 'package:pantry_io_mobile/domain/models/local_unit.dart';

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

  group('fuzzyFindLocalUnit tests', () {
    List<LocalUnit> mockUnits = [
      LocalUnit(id: 1, name: 'g', value: 1),
      LocalUnit(id: 2, name: 'cups', value: 1000),
      LocalUnit(id: 3, name: 'pcs', value: 1000),
      LocalUnit(id: 4, name: 'bulbs', value: 1),
      LocalUnit(id: 5, name: 'tbsp', value: 13),
      LocalUnit(id: 6, name: 'tsp', value: 10)
    ];
    test('returns empty list when parsedUnit is an empty string', () {
      final result = fuzzyFindLocalUnit(mockUnits, '');

      expect(result, isEmpty);
    });

    test('returns exact match correctly', () {
      final result = fuzzyFindLocalUnit(mockUnits, 'g');

      expect(result, isNotEmpty);
      expect(result.first.item.name, 'g');
    });

    test('handles minor typos in abbreviations', () {
      final result = fuzzyFindLocalUnit(mockUnits, 'tbs');

      expect(result.isNotEmpty, isTrue);
      expect(result.first.item.name, 'tbsp');
    });

    test('matches full grams to g', () {
      final result = fuzzyFindLocalUnit(mockUnits, 'grams');

      expect(result, isNotEmpty);
      expect(result.first.item.name, 'g');
    });
  });
}
