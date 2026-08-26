import 'package:flutter_test/flutter_test.dart';
import 'package:pantry_io_mobile/domain/models/recipe_form.dart';
import 'package:pantry_io_mobile/domain/models/ingredient_input.dart';

void main() {
  late RecipeFormModel model;
  group('isValid tests', () {
    setUp(() {
      model = RecipeFormModel();
    });
    test('returns true when all fields have information', () {
      model.nameController.text = 'name';
      model.instructionsController.text = 'instructions';
      model.ingredients[0] = IngredientInput(pantryId: 1, genericNameId: 1, quantityNeeded: '5', selectedUnit: 'unit', selectedNameId: 1);
      model.ingredients[0].qtyController.text = 'lots';

      final result = model.isValid();

      expect(result, isTrue);
    });

    test('returns false when name is empty', () {
      model.instructionsController.text = 'instructions';
      model.ingredients[0] = IngredientInput(pantryId: 1, genericNameId: 1, quantityNeeded: '5', selectedUnit: 'unit', selectedNameId: 1);
      model.ingredients[0].qtyController.text = 'lots';

      final result = model.isValid();

      expect(result, isFalse);
    });

    test('returns false when instructions is empty', () {
      model.nameController.text = 'name';
      model.ingredients[0] = IngredientInput(pantryId: 1, genericNameId: 1, quantityNeeded: '5', selectedUnit: 'unit', selectedNameId: 1);
      model.ingredients[0].qtyController.text = 'lots';

      final result = model.isValid();

      expect(result, isFalse);
    });

    test('returns false when ingredient pantryId is 0', () {
      model.nameController.text = 'name';
      model.instructionsController.text = 'instructions';
      model.ingredients[0] = IngredientInput(pantryId: 0, genericNameId: 1, quantityNeeded: '5', selectedUnit: 'unit', selectedNameId: 1);
      model.ingredients[0].qtyController.text = 'lots';

      final result = model.isValid();

      expect(result, isFalse);
    });

    test('returns false when ingredient qtyController is empty', () {
      model.nameController.text = 'name';
      model.instructionsController.text = 'instructions';
      model.ingredients[0] = IngredientInput(pantryId: 0,
          genericNameId: 1,
          quantityNeeded: '5',
          selectedUnit: 'unit',
          selectedNameId: 1);
      model.ingredients[0].qtyController.text = '';

      final result = model.isValid();

      expect(result, isFalse);
    });

    test('returns false when ingredient selectedUnit is null', () {
      model.nameController.text = 'name';
      model.instructionsController.text = 'instructions';
      model.ingredients[0] = IngredientInput(pantryId: 0, genericNameId: 1, quantityNeeded: '5', selectedNameId: 1);
      model.ingredients[0].qtyController.text = 'lots';

      final result = model.isValid();

      expect(result, isFalse);
    });

    test('returns false when selectedUnit is empty', () {
      model.nameController.text = 'name';
      model.instructionsController.text = 'instructions';
      model.ingredients[0] = IngredientInput(pantryId: 0, genericNameId: 1, quantityNeeded: '5', selectedUnit: '', selectedNameId: 1);
      model.ingredients[0].qtyController.text = 'lots';

      final result = model.isValid();

      expect(result, isFalse);
    });
  });
}