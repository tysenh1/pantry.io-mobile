import "package:drift/drift.dart";
import "package:pantry_io_mobile/data/database/tables/pantry_table.dart";
import "package:pantry_io_mobile/data/database/tables/recipes_table.dart";

class RecipeIngredients extends Table {
  IntColumn get recipeId =>
      integer().references(Recipes, #id, onDelete: KeyAction.cascade)();
  IntColumn get pantryId =>
      integer().references(Pantry, #id, onDelete: KeyAction.cascade)();
  RealColumn get quantityNeeded => real()();
  TextColumn get unit => text()();

  @override
  Set<Column> get primaryKey => {recipeId, pantryId};
}
