import 'package:drift/drift.dart';
import '../../database/app_database.dart';
import '../db/recipes.dart';
import '../db/recipe_ingredients.dart';
import '../ui/recipe_add.dart';

part 'recipe_dao.g.dart';

@DriftAccessor(tables: [Recipes, RecipeIngredients])
class RecipeDao extends DatabaseAccessor<AppDatabase> with _$RecipeDaoMixin {
  RecipeDao(AppDatabase db) : super(db);

  Future<void> createRecipe({
    required String name,
    required String instructions,
    String? rawTags,
    required List<RecipeIngredientsCompanion> ingredientCompanions,
  }) {
    return transaction(() async {
      final cleanedTags = rawTags?.trim().replaceAll(' ', '') ?? '';

      final recipeId = await into(recipes).insert(
        RecipesCompanion.insert(
          name: name,
          instructions: instructions,
          tags: cleanedTags,
        ),
      );

      for (var companion in ingredientCompanions) {
        await into(
          recipeIngredients,
        ).insert(companion.copyWith(recipeId: Value(recipeId)));
      }
    });
  }
}
