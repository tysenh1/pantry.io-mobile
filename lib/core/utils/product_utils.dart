import 'package:flutter/cupertino.dart';
import 'package:fuzzy/data/fuzzy_options.dart';
import 'package:fuzzy/data/result.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:pantry_io_mobile/domain/models/generic_name_info.dart';
import 'package:pantry_io_mobile/domain/models/local_unit.dart';

final UNIT_REGEX = RegExp(r'([0-9.]+)\s*([a-zA-Z]+)');

double parseQuantity(ProductResultV3 result) {
  double finalQuantity = 0.0;
  if (result.product?.quantity != null && result.product?.quantity != '') {
    final regexArray = UNIT_REGEX.firstMatch(result.product?.quantity as String);
    if (regexArray == null) {
      return finalQuantity;
    }
    finalQuantity = double.tryParse(regexArray.group(1).toString()) ?? 0.0;
  } else if (result.product?.packagingQuantity != null && result.product?.packagingQuantity != 0.0) {
    finalQuantity = result.product?.packagingQuantity as double;
  }

  return finalQuantity;
}

String parseUnit(ProductResultV3 result) {
  // String finalUnit = '';
  if (result.product?.quantity != null && result.product?.quantity != '') {
    final regexArray = UNIT_REGEX.firstMatch(result.product?.quantity as String);
    return regexArray?.group(2).toString() ?? '';
  }

  return '';
}

List<Result<LocalUnit>> fuzzyFindLocalUnit(ProductResultV3 result, List<LocalUnit> units, String parsedUnit) {
  final fuse = Fuzzy<LocalUnit>(
    units,
    options: FuzzyOptions(
      keys: [WeightedKey(name: 'name', getter: (u) => u.name, weight: 1.0)],
      threshold: 0.4
    )
  );

  if (parsedUnit != '') {
    final results = fuse.search(parsedUnit);

    results.sort((a, b) => a.score.compareTo(b.score));
    return results;
  }
  return [];
}

List<Result<GenericNameInfo>> findGenericMatch(String? genericName, String? productName, List<String>? categoriesTags, String? categoriesString, List<GenericNameInfo> genericNames) {
  List<String>? categories = categoriesString?.split(',');

  final uniqueResults = <int, Result<GenericNameInfo>>{};

  void addSearchResults(List<Result<GenericNameInfo>> results) {
    for (var result in results) {
      final itemId = result.item.id;
      final existingResult = uniqueResults[itemId];

      if (existingResult == null || result.score < existingResult.score) {
        uniqueResults[itemId] = result;
      }
    }
  }


  final fuse = Fuzzy<GenericNameInfo>(
    genericNames,
    options: FuzzyOptions(
      keys: [WeightedKey(name: 'name', getter: (g) => g.name, weight: 1.0)],
      threshold: 0.4
    ),
  );

  if (genericName != null && genericName != '') {
    final results = fuse.search(genericName);

    addSearchResults(results);
  }

  if (productName != null && productName != '') {
    final regex = RegExp(
      r'\d+(\.\d+)?\s*(oz|g|ml|kg|lb|pcs)',
      caseSensitive: false
    );
    final cleanedName = productName.replaceAll(regex, '').trim();
    // final splitName = cleanedName.split(' ');
    // for (var i = 0; i < splitName.length; i++) {
    //   final result = fuse.search(splitName[i]);
    //   searchResults.addAll(result);
    // }
    final results = fuse.search(cleanedName);
    addSearchResults(results);
  }

  if (categories != null && categories.isNotEmpty) {
    for (var i = 0; i < categories.length; i++) {

      final results = fuse.search(stripLanguagePrefix(categories[i].trim()));
      addSearchResults(results);
    }
  }
  if (categoriesTags != null && categoriesTags.isNotEmpty) {
    for (var i = 0; i < categoriesTags.length; i++) {
      final results = fuse.search(stripLanguagePrefix(categoriesTags[i].trim()));
      addSearchResults(results);
    }
  }
  final finalResults = uniqueResults.values.toList();

  finalResults.sort((a, b) => a.score.compareTo(b.score));

  return finalResults;

}

String stripLanguagePrefix(String input) {
  if (input.length > 2 && input[2] == ':') {
    return input.substring(3).trim();
  }
  return input.trim();
}
