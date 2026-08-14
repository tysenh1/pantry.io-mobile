import 'package:flutter_test/flutter_test.dart';
import 'package:pantry_io_mobile/core/utils/recipe_history_utils.dart';
import 'package:pantry_io_mobile/domain/models/recipe_history_with_ingredients.dart';

void main() {
  group('Date Utility Tests', () {
    test('isSameDay accurately compares dates', () {
      final date1 = DateTime(2024, 5, 10, 14, 30); // 2:30 PM
      final date2 = DateTime(2024, 5, 10, 8, 15);  // 8:15 AM
      final differentDay = DateTime(2024, 5, 11);
      final differentMonth = DateTime(2024, 6, 10);
      final differentYear = DateTime(2025, 5, 10);

      // Same day, different times
      expect(isSameDay(date1, date2), isTrue);

      // Different days/months/years
      expect(isSameDay(date1, differentDay), isFalse);
      expect(isSameDay(date1, differentMonth), isFalse);
      expect(isSameDay(date1, differentYear), isFalse);
    });

    test('formatDate returns Today and Yesterday dynamically', () {
      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(days: 1));

      expect(formatDate(now), 'Today');
      expect(formatDate(yesterday), 'Yesterday');
    });

    test('formatDate applies correct st, nd, rd, th suffixes', () {

      // 'st' suffixes
      expect(formatDate(DateTime(2024, 5, 1)), 'May 1st, 2024');
      expect(formatDate(DateTime(2024, 5, 21)), 'May 21st, 2024');
      expect(formatDate(DateTime(2024, 5, 31)), 'May 31st, 2024');

      // 'nd' suffixes
      expect(formatDate(DateTime(2024, 5, 2)), 'May 2nd, 2024');
      expect(formatDate(DateTime(2024, 5, 22)), 'May 22nd, 2024');

      // 'rd' suffixes
      expect(formatDate(DateTime(2024, 5, 3)), 'May 3rd, 2024');
      expect(formatDate(DateTime(2024, 5, 23)), 'May 23rd, 2024');

      // 'th' suffixes (Normal)
      expect(formatDate(DateTime(2024, 5, 4)), 'May 4th, 2024');
      expect(formatDate(DateTime(2024, 5, 9)), 'May 9th, 2024');
      expect(formatDate(DateTime(2024, 5, 30)), 'May 30th, 2024');

      // 'th' suffixes (The 11-13 exception block)
      expect(formatDate(DateTime(2024, 5, 11)), 'May 11th, 2024');
      expect(formatDate(DateTime(2024, 5, 12)), 'May 12th, 2024');
      expect(formatDate(DateTime(2024, 5, 13)), 'May 13th, 2024');
    });
  });

  group('Recipe History Filter Tests', () {
    late List<RecipeHistoryWithIngredients> mockHistory;

    setUp(() {
      mockHistory = [
        RecipeHistoryWithIngredients(
            id: 1,
            name: 'Chicken Soup',
            tags: {'dinner', 'soup', 'chicken'},
          instructions: '',
          ingredientsConsumed: [],
          cookedAt: DateTime.now(),
          multiplier: 1
        ),
        RecipeHistoryWithIngredients(
            id: 2,
            name: 'Beef Stew',
            tags: {'dinner', 'beef'},
            instructions: '',
            ingredientsConsumed: [],
            cookedAt: DateTime.now(),
            multiplier: 1
        ),
        RecipeHistoryWithIngredients(
            id: 3,
            name: 'Pancakes',
            tags: {'breakfast', 'sweet'},
            instructions: '',
            ingredientsConsumed: [],
            cookedAt: DateTime.now(),
            multiplier: 1
        ),
        RecipeHistoryWithIngredients(
            id: 4,
            name: 'Mystery Meal',
            tags: null, // Testing null safety
            instructions: '',
            ingredientsConsumed: [],
            cookedAt: DateTime.now(),
            multiplier: 1
        ),
      ];
    });

    test('filterRecipeHistoryByTags requires ALL tags to match', () {
      // Searching for BOTH 'dinner' and 'chicken'
      final results = filterRecipeHistoryByTags(mockHistory, {'dinner', 'chicken'});

      expect(results.length, 1);
      expect(results.first.name, 'Chicken Soup'); // Beef stew is dinner, but not chicken
    });

    test('filterRecipeHistoryByTags returns empty if tags do not match', () {
      final results = filterRecipeHistoryByTags(mockHistory, {'lunch'});
      expect(results, isEmpty);
    });

    test('filterRecipeHistoryByTags handles null tags safely', () {
      // Searching for 'dinner' should safely skip 'Mystery Meal' without crashing
      final results = filterRecipeHistoryByTags(mockHistory, {'dinner'});

      expect(results.length, 2);
      final names = results.map((e) => e.name).toList();
      expect(names.contains('Mystery Meal'), isFalse);
    });

    test('filterRecipeHistoryBySearchQuery returns exact match', () {
      final results = filterRecipeHistoryBySearchQuery(mockHistory, 'Pancakes');

      expect(results.length, 1);
      expect(results.first.name, 'Pancakes');
    });

    test('filterRecipeHistoryBySearchQuery handles typos (fuzzy match)', () {
      // "chiken" instead of "chicken"
      final results = filterRecipeHistoryBySearchQuery(mockHistory, 'chiken');

      expect(results.isNotEmpty, isTrue);
      expect(results.first.name, 'Chicken Soup');
    });

    test('filterRecipeHistoryBySearchQuery returns empty list for no match', () {
      final results = filterRecipeHistoryBySearchQuery(mockHistory, 'Waffles');

      expect(results, isEmpty);
    });
  });
}