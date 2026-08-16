import 'package:flutter_test/flutter_test.dart';
import 'package:pantry_io_mobile/core/constants/recipe_history_sort_order.dart';
import 'package:pantry_io_mobile/data/database/tables/recipe_history_table.dart';
import 'package:pantry_io_mobile/domain/models/recipe_history_with_ingredients.dart';
import 'package:pantry_io_mobile/domain/services/recipe_history_service.dart';

void main() {
  RecipeHistoryWithIngredients buildTestHistory({
    required int id,
    required String name,
    required DateTime cookedAt,
    Set<String>? tags,
  }) {
    return RecipeHistoryWithIngredients(
      id: id,
      name: name,
      tags: tags,
      cookedAt: cookedAt,
      instructions: 'instructions',
      ingredientsConsumed: [ConsumedIngredient(name: 'ing1', quantity: 1, unit: 'g')],
      multiplier: 1.0
    );
  }

  group('RecipeHistoryService Tests', () {
    late RecipeHistoryService service;
    late List<RecipeHistoryWithIngredients> mockHistory;

    setUp(() {
      service = RecipeHistoryService();
      mockHistory = [
        buildTestHistory(
          id: 1,
          name: 'Pasta',
          tags: {'dinner', 'carb'},
          cookedAt: DateTime(2023, 1, 1),
        ),
        buildTestHistory(
          id: 2,
          name: 'Salad',
          tags: {'lunch', 'healthy'},
          cookedAt: DateTime(2023, 1, 3),
        ),
        buildTestHistory(
          id: 3,
          name: 'Steak',
          tags: {'dinner', 'meat'},
          cookedAt: DateTime(2023, 1, 2),
        ),
      ];
    });

    test('sortRecipeHistory by dateDesc', () {
      final results = service.sortRecipeHistory(recipes: mockHistory);

      expect(results[0].name, 'Salad');
      expect(results[1].name, 'Steak');
      expect(results[2].name, 'Pasta');
    });

    test('sortRecipeHistory by dateAsc', () {
      final results = service.sortRecipeHistory(
        recipes: mockHistory,
        sortOrder: RecipeHistorySortOrder.dateAsc,
      );

      expect(results[0].name, 'Pasta');
      expect(results[1].name, 'Steak');
      expect(results[2].name, 'Salad');
    });

    test('filterRecipeHistory returns original list when no filters provided', () {
      final results = service.filterRecipeHistory(recipes: mockHistory);

      expect(results.length, 3);
    });

    test('filterRecipeHistory applies selectedTags', () {
      final results = service.filterRecipeHistory(
        recipes: mockHistory,
        selectedTags: {'dinner'},
      );

      expect(results.length, 2);
      expect(results.any((r) => r.name == 'Salad'), isFalse);
    });

    test('filterRecipeHistory applies searchQuery', () {
      final results = service.filterRecipeHistory(
        recipes: mockHistory,
        searchQuery: 'Salad',
      );

      expect(results.length, 1);
      expect(results.first.name, 'Salad');
    });

    test('filterRecipeHistory applies both tags and search', () {
      final results = service.filterRecipeHistory(
        recipes: mockHistory,
        searchQuery: 'Steak',
        selectedTags: {'dinner'},
      );

      expect(results.length, 1);
      expect(results.first.name, 'Steak');
    });

    test('process applies filters and sorts dateDesc', () {
      final results = service.process(
        recipes: mockHistory,
        selectedTags: {'dinner'},
      );

      expect(results.length, 2);
      expect(results[0].name, 'Steak');
      expect(results[1].name, 'Pasta');
    });

    test('process applies filters and sorts dateAsc', () {
      final results = service.process(
        recipes: mockHistory,
        selectedTags: {'dinner'},
        sortOrder: RecipeHistorySortOrder.dateAsc,
      );

      expect(results.length, 2);
      expect(results[0].name, 'Pasta');
      expect(results[1].name, 'Steak');
    });
  });
}