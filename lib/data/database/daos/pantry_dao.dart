import 'package:drift/drift.dart';
import 'package:pantry_io_mobile/core/utils/pantry_utils.dart';
import 'package:pantry_io_mobile/core/utils/unit_converter.dart';
import 'package:pantry_io_mobile/data/database/tables/pantry_table.dart';
import 'package:pantry_io_mobile/data/database/tables/recipe_ingredients_table.dart';
import 'package:pantry_io_mobile/data/database/tables/generic_names_table.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';

part 'pantry_dao.g.dart';

@DriftAccessor(tables: [Pantry, RecipeIngredients, GenericNames])
class PantryDao extends DatabaseAccessor<AppDatabase> with _$PantryDaoMixin {
  PantryDao(AppDatabase db) : super(db);

  Future<void> subtractRecipeIngredientQuantities(int recipeId) async {
    final query = select(recipeIngredients).join([
      innerJoin(pantry, pantry.id.equalsExp(recipeIngredients.pantryId)),
      innerJoin(genericNames, genericNames.id.equalsExp(pantry.genericNameId)),
    ])..where(recipeIngredients.recipeId.equals(recipeId));

    final rows = await query.get();

    for (final row in rows) {
      final recipeIngredient = row.readTable(recipeIngredients);
      final pantryItem = row.readTable(pantry);
      final generic = row.readTable(genericNames);

      final newQuantity = subtractQuantity(
        pantryItem.quantity,
        generic.primaryUnit,
        generic.weightPerPiece,
        recipeIngredient.quantityNeeded,
        recipeIngredient.unit,
      );

      final newQuantityWithOldUnit = normalizeQuantity(
        newQuantity.toDouble(),
        recipeIngredient.unit,
      );

      await (update(pantry)..where((t) => t.id.equals(pantryItem.id))).write(
        PantryCompanion(quantity: Value(newQuantityWithOldUnit.floor())),
      );
    }
  }

  Future<PantryData> getPantryItemByGenericNameId(int genericNameId) async {
    final query = select(pantry)..where((tbl) => tbl.genericNameId.equals(genericNameId));

    return await query.getSingle();
  }

  Future<int> insertPantryItem()

}
