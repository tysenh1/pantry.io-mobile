

import 'package:flutter_test/flutter_test.dart';
import 'package:pantry_io_mobile/core/utils/get_recipe_utils.dart';
import 'package:pantry_io_mobile/domain/models/recipe_with_ingredients.dart';

void main() {
  late List<RecipeWithIngredients> testRecipes;


  group('filterCookableRecipes Tests', () {
    setUpAll(() {
      testRecipes = [
        RecipeWithIngredients(id: 1, name: 'test1', instructions: 'instructions1', ingredients: [IngredientItem(pantryId: 1, quantityNeeded: 50, ingredientUnit: 'g', pantryQuantity: 100, pantryUnit: 'g', name: 'testIng1', gramWeight: 1, genericNameId: 1)], isRecipeComplete: true),
        RecipeWithIngredients(id: 2, name: 'test2', instructions: 'instructions2', ingredients: [IngredientItem(pantryId: 2, quantityNeeded: 100, ingredientUnit: 'oz', pantryQuantity: 200000, pantryUnit: 'g', name: 'testIng2', gramWeight: 13, genericNameId: 1)], isRecipeComplete: true),
      ];
    });
    test('returns given list of valid recipes', () {
      final result = filterCookableRecipes(testRecipes);

      expect(result, testRecipes);
    });
  });
}