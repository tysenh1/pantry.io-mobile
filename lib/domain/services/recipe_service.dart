import 'package:pantry_io_mobile/core/utils/unit_converter.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/recipe_history_with_ingredients.dart';
import 'package:pantry_io_mobile/domain/models/recipe_with_ingredients.dart';

class RecipeService {
  final AppDatabase _db;

  RecipeService(this._db);

  Future<void> cookRecipe(
      RecipeWithIngredients recipe,
      double multiplier,
      ) async {
    await _db.transaction(() async {
      for (final ingredient in recipe.ingredients) {
        final normalizedQuantity = normalizeQuantity(ingredient.quantityNeeded, ingredient.ingredientUnit);
        await _db.pantryDao.subtractQuantity(normalizedQuantity, ingredient.pantryId);

        await _db.recipeHistoryDao.insert(RecipeHistoryWithIngredients.fromRecipe(recipe, multiplier, DateTime.now()));
      }
    });
  }
}