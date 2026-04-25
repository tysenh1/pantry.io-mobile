import "package:drift/drift.dart";
import "package:pantry_io_mobile/core/data/database/tables/pantry.dart";
import "package:pantry_io_mobile/core/data/database/tables/recipes.dart";

class RecipeIngredients extends Table {
  TextColumn get recipeId =>
      text().references(Recipes, #id, onDelete: KeyAction.cascade)();
  TextColumn get pantryId =>
      text().references(Pantry, #id, onDelete: KeyAction.cascade)();
  IntColumn get quantityNeeded => integer()();
  TextColumn get unit => text()();

  @override
  Set<Column> get primaryKey => {recipeId, pantryId};
}
