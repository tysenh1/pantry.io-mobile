import 'package:flutter_test/flutter_test.dart';
import 'package:pantry_io_mobile/core/constants/get_recipe_sort_order.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/data/database/daos/pantry_dao.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pantry_io_mobile/data/database/daos/recipe_history_dao.dart';
import 'package:pantry_io_mobile/domain/models/recipe_history_with_ingredients.dart';
import 'package:pantry_io_mobile/domain/models/recipe_with_ingredients.dart';
import 'package:pantry_io_mobile/domain/services/get_recipe_service.dart';

class MockAppDatabase extends Mock implements AppDatabase {}
class MockPantryDao extends Mock implements PantryDao {}
class MockRecipeHistoryDao extends Mock implements RecipeHistoryDao {}
class FakeRecipeHistoryWithIngredients extends Fake implements RecipeHistoryWithIngredients {}

Future<Null> fallbackNullCallback() async { return null; }
Future<void> fallbackVoidCallback() async {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeRecipeHistoryWithIngredients());

    registerFallbackValue(fallbackNullCallback);
    registerFallbackValue(fallbackVoidCallback);
  });

  RecipeWithIngredients buildTestRecipe({
    required int id,
    required String name,
    bool isComplete = true,
    Set<String>? tags,
  }) {
    return RecipeWithIngredients(
      id: id,
      name: name,
      tags: tags,
      instructions: 'instructions',
      ingredients: [IngredientItem(
          pantryId: 1,
          quantityNeeded: 1,
          ingredientUnit: 'g',
          pantryQuantity: 2,
          pantryUnit: 'g',
          name: 'ingredient',
          gramWeight: 1,
          genericNameId: 1)],
      isRecipeComplete: isComplete
    );
  }

  group('cookRecipe tests', () {
    late MockAppDatabase mockDb;
    late MockPantryDao mockPantryDao;
    late MockRecipeHistoryDao mockRecipeHistoryDao;
    setUp(() {
      mockDb = MockAppDatabase();
      mockPantryDao = MockPantryDao();
      mockRecipeHistoryDao = MockRecipeHistoryDao();

      when(() => mockDb.pantryDao).thenReturn(mockPantryDao);
      when(() => mockDb.recipeHistoryDao).thenReturn(mockRecipeHistoryDao);

      when(() => mockDb.transaction<Null>(any())).thenAnswer((invocation) async {
        final callback = invocation.positionalArguments.first as Function();
        return await callback();
      });

      when(() => mockDb.transaction<void>(any())).thenAnswer((invocation) async {
        final callback = invocation.positionalArguments.first as Function;
        return await callback();
      });
    });

    test('calculates correct quantities, rounds them, and updates daos', () async {
      when(() => mockPantryDao.subtractQuantity(any(), any())).thenAnswer((_) => Future.value());
      when(() => mockRecipeHistoryDao.insert(any())).thenAnswer((_) => Future.value(1));

      final ingredient1 = IngredientItem(
        pantryId: 1,
        quantityNeeded: 1.333,
        ingredientUnit: 'oz',
        pantryQuantity: 1000000,
        pantryUnit: 'g',
        isOptional: false,
        name: 'ing1',
        gramWeight: 100,
        genericNameId: 1
      );

      final ingredient2 = IngredientItem(
        pantryId: 2,
        quantityNeeded: 0.5,
        ingredientUnit: 'oz',
        pantryQuantity: 1000000,
        pantryUnit: 'g',
        isOptional: false,
        name: 'ing2',
        gramWeight: 15,
        genericNameId: 2
      );

      final mockRecipe = RecipeWithIngredients(
        id: 1,
        name: 'recipe1',
        tags: null,
        instructions: 'instructions',
        ingredients: [ingredient1, ingredient2],
        isRecipeComplete: true
      );

      await GetRecipeService().cookRecipe(mockRecipe, 1.0, mockDb);


      verify(() => mockPantryDao.subtractQuantity(134, 1)).called(1);
      verify(() => mockPantryDao.subtractQuantity(8, 2)).called(1);
      verify(() => mockRecipeHistoryDao.insert(any())).called(1);
    });

    test('applies the multiplier correctly to pantry subtractions and rounds correctly', () async {
      when(() => mockPantryDao.subtractQuantity(any(), any())).thenAnswer((_) async {});
      when(() => mockRecipeHistoryDao.insert(any())).thenAnswer((_) async => 1);

      final ingredient1 = IngredientItem(
          pantryId: 1,
          quantityNeeded: 1.333,
          ingredientUnit: 'oz',
          pantryQuantity: 1000000,
          pantryUnit: 'g',
          isOptional: false,
          name: 'ing1',
          gramWeight: 1,
          genericNameId: 1
      );

      final ingredient2 = IngredientItem(
          pantryId: 2,
          quantityNeeded: 0.5,
          ingredientUnit: 'oz',
          pantryQuantity: 1000000,
          pantryUnit: 'g',
          isOptional: false,
          name: 'ing2',
          gramWeight: 15,
          genericNameId: 2
      );

      final mockRecipe = RecipeWithIngredients(
          id: 1,
          name: 'recipe1',
          tags: null,
          instructions: 'instructions',
          ingredients: [ingredient1, ingredient2],
          isRecipeComplete: true,
      );

      await GetRecipeService().cookRecipe(mockRecipe, 2.0, mockDb);

      verify(() => mockPantryDao.subtractQuantity(3, 1));
      verify(() => mockPantryDao.subtractQuantity(15, 2));
      verify(() => mockRecipeHistoryDao.insert(any())).called(1);
    });
  });


  group('sortRecipes tests', () {
    late List<RecipeWithIngredients> unsortedRecipes;
    setUp(() {
      unsortedRecipes = [
        buildTestRecipe(id: 1, name: 'Zebra Cake'),
        buildTestRecipe(id: 2, name: 'Apple Pie'),
        buildTestRecipe(id: 3, name: 'Mango Salsa')
      ];
    });
    test('sorts by name ascending by default', () {
      final result = GetRecipeService().sortRecipes(recipes: unsortedRecipes);

      expect(result[0].name, 'Apple Pie');
      expect(result[1].name, 'Mango Salsa');
      expect(result[2].name, 'Zebra Cake');
    });

    test('sorts by name descending when specified', () {
      final result = GetRecipeService().sortRecipes(recipes: unsortedRecipes, sortOrder: GetRecipeSortOrder.nameDesc);

      expect(result[0].name, 'Zebra Cake');
      expect(result[1].name, 'Mango Salsa');
      expect(result[2].name, 'Apple Pie');
    });
  });

  group('filterRecipes tests', () {
    late List<RecipeWithIngredients> mockRecipes;

    setUp(() {
      mockRecipes = [
        buildTestRecipe(id: 1, name: 'Chicken Soup', tags: {'dinner', 'soup'}, isComplete: true),
        buildTestRecipe(id: 2, name: 'Beef Stew', tags: {'dinner', 'beef'}, isComplete: true),
        buildTestRecipe(id: 3, name: 'Pancakes', tags: {'breakfast'}, isComplete: false)
      ];
    });

    test('returns original list when no filters are applied', () {
      final result = GetRecipeService().filterRecipes(recipes: mockRecipes);

      expect(result.length, 3);
    });

    test('filters out incomplete recipes when showIncompleteRecipes is false', () {
      final result = GetRecipeService().filterRecipes(recipes: mockRecipes, showIncompleteRecipes: false);

      expect(result.length, 2);
      expect(result.any((r) => r.name == 'Pancakes'), isFalse);
    });

    test('keeps incomplete recipes with showIncompleteRecipes is true or null', () {
      final resultTrue = GetRecipeService().filterRecipes(recipes: mockRecipes, showIncompleteRecipes: true);
      expect(resultTrue.length, 3);

      final resultNull = GetRecipeService().filterRecipes(recipes: mockRecipes, showIncompleteRecipes: null);
      expect(resultNull.length, 3);
    });

    test('filters by seletedTags when provided', () {
      final result = GetRecipeService().filterRecipes(recipes: mockRecipes, selectedTags: {'soup'});
      expect(result.length, 1);
      expect(result.first.name, 'Chicken Soup');
    });

    test('ignores selectedTags if the set is empty', () {
      final result = GetRecipeService().filterRecipes(recipes: mockRecipes, selectedTags: {});

      expect(result.length, 3);
    });

    test('filters by searchQuery when provided', () {
      final result = GetRecipeService().filterRecipes(recipes: mockRecipes, searchQuery: 'Beef');

      expect(result.length, 1);
      expect(result.first.name, 'Beef Stew');
    });

    test('ignores searchQuery if the string is empty', () {
      final result = GetRecipeService().filterRecipes(recipes: mockRecipes, searchQuery: '');

      expect(result.length, 3);
    });

    test('applies all filters combined sequentially', () {
      final result = GetRecipeService().filterRecipes(
        recipes: mockRecipes,
        showIncompleteRecipes: false,
        selectedTags: {'dinner'},
        searchQuery: 'Chicken'
      );

      expect(result.length, 1);
      expect(result.first.name, 'Chicken Soup');
    });
  });

  group('process (Integration) Tests', () {
    late List<RecipeWithIngredients> mockRecipes;

    setUp(() {
      mockRecipes = [
        buildTestRecipe(id: 1, name: 'Zucchini Bread', tags: {'baking', 'sweet'}),
        buildTestRecipe(id: 2, name: 'Apple Pie', tags: {'baking', 'sweet'}),
        buildTestRecipe(id: 3, name: 'Beef Stew', tags: {'dinner'}),
        buildTestRecipe(id: 4, name: 'Banana Muffin', tags: {'baking'}, isComplete: false),
      ];
    });

    test('default parameters return all recipes sorted A-Z', () {
      final results = GetRecipeService().process(recipes: mockRecipes);

      expect(results.length, 4);
      expect(results[0].name, 'Apple Pie');
      expect(results[1].name, 'Banana Muffin');
      expect(results[2].name, 'Beef Stew');
      expect(results[3].name, 'Zucchini Bread');
    });

    test('applies filter first, then sorts remaining items A-Z', () {
      final results = GetRecipeService().process(
        recipes: mockRecipes,
        selectedTags: {'baking'},
      );

      expect(results.length, 3);
      expect(results[0].name, 'Apple Pie');
      expect(results[1].name, 'Banana Muffin');
      expect(results[2].name, 'Zucchini Bread');
    });

    test('applies filter first, then sorts remaining items Z-A (Descending)', () {
      final results = GetRecipeService().process(
        recipes: mockRecipes,
        selectedTags: {'baking'},
        sortOrder: GetRecipeSortOrder.nameDesc,
      );

      expect(results.length, 3);
      expect(results[0].name, 'Zucchini Bread');
      expect(results[1].name, 'Banana Muffin');
      expect(results[2].name, 'Apple Pie');
    });

    test('handles the ultimate combo: search, tags, completion toggle, and custom sort', () {
      final results = GetRecipeService().process(
        recipes: mockRecipes,
        showIncompleteRecipes: false,
        selectedTags: {'sweet'},
        searchQuery: 'Zucchini',
        sortOrder: GetRecipeSortOrder.nameDesc,
      );

      expect(results.length, 1);
      expect(results.first.name, 'Zucchini Bread');
    });
  });
}