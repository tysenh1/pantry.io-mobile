

import 'package:flutter_test/flutter_test.dart';
import 'package:pantry_io_mobile/core/utils/get_recipe_utils.dart';
import 'package:pantry_io_mobile/domain/models/recipe_with_ingredients.dart';

void main() {
  late List<RecipeWithIngredients> validRecipes;
  late List<RecipeWithIngredients> mockSearchRecipes;
  final RecipeWithIngredients invalidRecipe = RecipeWithIngredients(id: 3, name: 'test3', instructions: 'instructions3', ingredients: [IngredientItem(pantryId: 1, quantityNeeded: 50, ingredientUnit: 'g', pantryQuantity: 10, pantryUnit: 'g', name: 'testIng1', gramWeight: 1, genericNameId: 1)], isRecipeComplete: true, tags: {'tag5', 'tag6'});

  setUpAll(() {
    validRecipes = [
      RecipeWithIngredients(id: 1, name: 'test1', instructions: 'instructions1', ingredients: [IngredientItem(pantryId: 1, quantityNeeded: 50, ingredientUnit: 'g', pantryQuantity: 100, pantryUnit: 'g', name: 'testIng1', gramWeight: 1, genericNameId: 1)], isRecipeComplete: true, tags: {'tag1', 'tag2'}),
      RecipeWithIngredients(id: 2, name: 'test2', instructions: 'instructions2', ingredients: [IngredientItem(pantryId: 2, quantityNeeded: 100, ingredientUnit: 'oz', pantryQuantity: 200000, pantryUnit: 'g', name: 'testIng2', gramWeight: 13, genericNameId: 1)], isRecipeComplete: true, tags: {'tag3', 'tag4'}),
    ];
  });
  group('filterCookableRecipes tests', () {

    test('returns given list of valid recipes', () {
      final result = filterCookableRecipes(validRecipes);

      expect(result.length, 2);
      expect(result, validRecipes);
    });

    // test('returns valid recipes when invalid recipes are present', () {
    //   final validAndInvalidRecipes = [
    //     ...validRecipes,
    //     invalidRecipe
    //   ];
    //
    //   final result = filterCookableRecipes(validAndInvalidRecipes);
    //
    //   expect(result.length, 2);
    //   expect(result, validRecipes);
    // });

    // test('returns an empty array when only invalid recipes are present', () {
    //   final result = filterCookableRecipes([invalidRecipe]);
    //
    //   expect(result, []);
    // });
  });

  group('filterRecipesByTags tests', () {
    test('returns matching recipes when one tag is given', () {
      final tags = {'tag1'};

      final result = filterRecipesByTags(validRecipes, tags);

      expect(result.length, 1);
      expect(result, [validRecipes[0]]);
    });

    test('returns matching recipes when a different tag is given', () {
      final tags = {'tag4'};

      final result = filterRecipesByTags(validRecipes, tags);

      expect(result.length, 1);
      expect(result, [validRecipes[1]]);
    });

    test('returns zero recipes when two tags are given', () {
      final tags = {'tag1', 'tag4'};

      final result = filterRecipesByTags(validRecipes, tags);

      expect(result, []);
    });

    test('returns zero recipes when unique tags are given', () {
      final tags = {'notPresentTag1', 'notPresentTag2'};

      final result = filterRecipesByTags(validRecipes, tags);

      expect(result, []);
    });

    test('returns both recipes when no tags are given', () {
      final Set<String> tags = {};

      final result = filterRecipesByTags(validRecipes, tags);

      expect(result.length, 2);
      expect(result, validRecipes);
    });
  });

  group('filterRecipesBySearchQuery', () {
    setUpAll(() {
      mockSearchRecipes = [
        RecipeWithIngredients(id: 1, name: 'Spicy Chicken Curry', instructions: 'instructions1', ingredients: [IngredientItem(pantryId: 1, quantityNeeded: 50, ingredientUnit: 'g', pantryQuantity: 100, pantryUnit: 'g', name: 'testIng1', gramWeight: 1, genericNameId: 1)], isRecipeComplete: true, tags: {'tag1', 'tag2'}),
        RecipeWithIngredients(id: 2, name: 'Beef Stew', instructions: 'instructions1', ingredients: [IngredientItem(pantryId: 1, quantityNeeded: 50, ingredientUnit: 'g', pantryQuantity: 100, pantryUnit: 'g', name: 'testIng1', gramWeight: 1, genericNameId: 1)], isRecipeComplete: true, tags: {'tag1', 'tag2'}),
        RecipeWithIngredients(id: 3, name: 'Vegan Pasta', instructions: 'instructions1', ingredients: [IngredientItem(pantryId: 1, quantityNeeded: 50, ingredientUnit: 'g', pantryQuantity: 100, pantryUnit: 'g', name: 'testIng1', gramWeight: 1, genericNameId: 1)], isRecipeComplete: true, tags: {'tag1', 'tag2'}),
        RecipeWithIngredients(id: 4, name: 'Chicken Noodle Soup', instructions: 'instructions1', ingredients: [IngredientItem(pantryId: 1, quantityNeeded: 50, ingredientUnit: 'g', pantryQuantity: 100, pantryUnit: 'g', name: 'testIng1', gramWeight: 1, genericNameId: 1)], isRecipeComplete: true, tags: {'tag1', 'tag2'}),
        RecipeWithIngredients(id: 5, name: 'Chocolate Cake', instructions: 'instructions1', ingredients: [IngredientItem(pantryId: 1, quantityNeeded: 50, ingredientUnit: 'g', pantryQuantity: 100, pantryUnit: 'g', name: 'testIng1', gramWeight: 1, genericNameId: 1)], isRecipeComplete: true, tags: {'tag1', 'tag2'}),
      ];
    });

    test('returns exact match', () {
      final result = filterRecipesBySearchQuery(mockSearchRecipes, 'Beef Stew');

      expect(result.length, 1);
      expect(result.first.name, 'Beef Stew');
    });

    test('is case insensitive', () {
      final result = filterRecipesBySearchQuery(mockSearchRecipes, 'CHOCOLATE CAKE');

      expect(result.length, 1);
      expect(result.first.name, 'Chocolate Cake');
    });

    test('handles minor typos', () {
      final result1 = filterRecipesBySearchQuery(mockSearchRecipes, 'chiken');
      final result2 = filterRecipesBySearchQuery(mockSearchRecipes, 'chiken noodel suop');
      final result3 = filterRecipesBySearchQuery(mockSearchRecipes, 'bef steww');

      final result1Names = result1.map((r) => r.name).toList();

      expect(result1.length, 2);
      expect(result1Names.contains('Spicy Chicken Curry'), isTrue);
      expect(result1Names.contains('Chicken Noodle Soup'), isTrue);

      expect(result2.length, 1);
      expect(result2.first.name, 'Chicken Noodle Soup');

      expect(result3.length, 1);
      expect(result3.first.name, 'Beef Stew');
    });

    test('handles an empty recipe list safely', () {
      final result = filterRecipesBySearchQuery([], 'query');

      expect(result, isEmpty);
    });
  });
}