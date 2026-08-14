import 'package:flutter_test/flutter_test.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:pantry_io_mobile/core/utils/product_utils.dart';
import 'package:pantry_io_mobile/domain/models/generic_name_info.dart';
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

    test('fuzzy find handles minor typos part 2', () {
      final result = fuzzyFindLocalUnit(mockUnits, 'tsps');

      expect(result.length, 1);
      expect(result.first.item.name, 'tsp');
    });
  });

  group('findGenericMatch Tests', () {
    late List<GenericNameInfo> mockGenerics;

    setUp(() {
      mockGenerics = [
        GenericNameInfo(id: 1, name: 'Milk', units: {1: LocalUnit(id: 1, name: 'g', value: 1)}, pantryId: 1),
        GenericNameInfo(id: 2, name: 'Tomato Sauce', units: {1: LocalUnit(id: 1, name: 'g', value: 1)}, pantryId: 2),
        GenericNameInfo(id: 3, name: 'Potato Chips', units: {1: LocalUnit(id: 1, name: 'g', value: 1)}, pantryId: 3),
        GenericNameInfo(id: 4, name: 'Dark Chocolate', units: {1: LocalUnit(id: 1, name: 'g', value: 1)}, pantryId: 4),
      ];
    });

    test('returns empty list when all inputs are null or empty', () {
      final results = findGenericMatch(null, null, null, null, mockGenerics);
      expect(results, isEmpty);

      final resultsEmpty = findGenericMatch('', '', [], '', mockGenerics);
      expect(resultsEmpty, isEmpty);
    });

    test('matches on genericName alone', () {
      final results = findGenericMatch('Milk', null, null, null, mockGenerics);

      expect(results.length, 1);
      expect(results.first.item.name, 'Milk');
    });

    test('Regex strips weight/volume from productName before searching', () {
      final results = findGenericMatch(null, 'Tomato Sauce 500g', null, null, mockGenerics);

      expect(results.isNotEmpty, isTrue);
      expect(results.first.item.name, 'Tomato Sauce');

      final results2 = findGenericMatch(null, 'Milk 1.5 kg', null, null, mockGenerics);
      expect(results2.isNotEmpty, isTrue);
      expect(results2.first.item.name, 'Milk');
    });

    test('splits and matches from categoriesString', () {
      final results = findGenericMatch(null, null, null, 'Dairy, Milk', mockGenerics);

      expect(results.isNotEmpty, isTrue);
      expect(results.first.item.name, 'Milk');
    });

    test('iterates and matches from categoriesTags list', () {
      final tags = ['Snacks', 'Potato Chips'];
      final results = findGenericMatch(null, null, tags, null, mockGenerics);

      expect(results.isNotEmpty, isTrue);
      expect(results.first.item.name, 'Potato Chips');
    });

    test('Deduplication: Only returns unique items even if multiple fields match', () {
      final results = findGenericMatch(
          'Tomato Sauce',
          'Tomato Sauce 24oz',
          ['Tomato Sauce'],
          null,
          mockGenerics
      );

      expect(results.length, 1);
      expect(results.first.item.id, 2);
    });

    test('Deduplication: Keeps the BEST (lowest) score when duplicates happen', () {
      final results = findGenericMatch(
          'Milkk',
          'Milk 500ml',
          null,
          null,
          mockGenerics
      );

      expect(results.length, 1);
      expect(results.first.item.name, 'Milk');
      expect(results.first.score, 0.0);
    });

    test('combines and sorts multiple different matches correctly', () {
      final results = findGenericMatch(
          'Milk',
          null,
          ['Dark Chocolate'],
          null,
          mockGenerics
      );

      expect(results.length, 2);
      expect(results[0].score <= results[1].score, isTrue);

      final matchedNames = results.map((r) => r.item.name).toList();
      expect(matchedNames.contains('Milk'), isTrue);
      expect(matchedNames.contains('Dark Chocolate'), isTrue);
    });
  });
}
