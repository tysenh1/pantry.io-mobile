import 'package:drift/drift.dart';
import '../../database/app_database.dart';
import '../db/recipes.dart';
import '../db/recipe_ingredients.dart';
import '../ui/recipe_add.dart';

part 'recipe_dao.g.dart';

@DriftAccessor(tables: [Recipes, RecipeIngredients])
class RecipeDao extends DatabaseAccessor<AppDatabase> with _$RecipeDaoMixin {
  RecipeDao(AppDatabase db) : super(db);

  Future<void> createRecipe(RecipeFormModel recipeData) {
    final cleanedTags = recipeData.tags.trim().replaceAll(' ', '');
  }
}
