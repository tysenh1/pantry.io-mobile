import 'package:drift/drift.dart';
import 'package:pantry_io_mobile/data/database/tables/pantry_table.dart';
import 'package:pantry_io_mobile/data/database/tables/recipe_ingredients_table.dart';
import 'package:pantry_io_mobile/data/database/tables/generic_names_table.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';

part 'pantry_dao.g.dart';

@DriftAccessor(tables: [Pantry, RecipeIngredients, GenericNames])
class PantryDao extends DatabaseAccessor<AppDatabase> with _$PantryDaoMixin {
  PantryDao(AppDatabase db) : super(db);

  // Future<void> subtractRecipeIngredientQuantities(int recipeId) async {
  //   final query = select(recipeIngredients).join([
  //     innerJoin(pantry, pantry.id.equalsExp(recipeIngredients.pantryId)),
  //     innerJoin(genericNames, genericNames.id.equalsExp(pantry.genericNameId)),
  //   ])..where(recipeIngredients.recipeId.equals(recipeId));
  //
  //   final rows = await query.get();
  //
  //   for (final row in rows) {
  //     final recipeIngredient = row.readTable(recipeIngredients);
  //     final pantryItem = row.readTable(pantry);
  //     final generic = row.readTable(genericNames);
  //
  //     final newQuantity = subtractQuantity(
  //       pantryItem.quantity,
  //       generic.primaryUnit,
  //       generic.weightPerPiece,
  //       recipeIngredient.quantityNeeded,
  //       recipeIngredient.unit,
  //     );
  //
  //     final newQuantityWithOldUnit = normalizeQuantity(
  //       newQuantity.toDouble(),
  //       recipeIngredient.unit,
  //     );
  //
  //     await (update(pantry)..where((t) => t.id.equals(pantryItem.id))).write(
  //       PantryCompanion(quantity: Value(newQuantityWithOldUnit.floor().toDouble())),
  //     );
  //   }
  // }
  //
  // Future<PantryData> getPantryItemByGenericNameId(int genericNameId) async {
  //   final query = select(pantry)..where((tbl) => tbl.genericNameId.equals(genericNameId));
  //
  //   return await query.getSingle();
  // }

  Future<PantryCompanion> getPantryItemById(int pantryId) async {
    final item = await (pantry.select()..where((p) => p.id.equals(pantryId))).getSingle();
    return PantryCompanion.insert(
      id: Value(item.id),
      genericNameId: item.genericNameId,
      quantity: Value(item.quantity),
      unit: item.unit
    );
  }

  Future<PantryCompanion> getPantryFromGenericNameId(int genericNameId) async {
    final item = await (pantry.select()..where((p) => p.genericNameId.equals(genericNameId))).getSingle();
    return PantryCompanion.insert(id: Value(item.id), genericNameId: item.genericNameId, unit: item.unit, quantity: Value(item.quantity));
  }

  Future<void> subtractQuantity(double amount, int pantryId) async {
    final row = await (select(pantry)
      ..where((p) => p.id.equals(pantryId))
    ).getSingle();

    await (update(pantry)
      ..where((p) => p.id.equals(pantryId))
    ).write(PantryCompanion(quantity: Value(row.quantity - amount)));
  }

  Future<void> updatePantry(PantryCompanion pantryItem, double productQuantity, int pantryId) async {
    return transaction(() async {
      final newQuantity = pantryItem.quantity.value + productQuantity;
      final updatedItem = pantryItem.copyWith(
        quantity: Value(newQuantity),
      );
      await update(pantry).replace(updatedItem);
    });
  }

  Future<void> updatePantryByGenericId(PantryCompanion pantryItem, double productQuantity) async {
    return transaction(() async {
      final existingItem = await (pantry.select()..where((p) => p.genericNameId.equals(pantryItem.genericNameId.value))).getSingle();
      final newQuantity = pantryItem.quantity.value + productQuantity;
      final updatedItem = pantryItem.copyWith(
        id: Value(existingItem.id),
        quantity: Value(newQuantity)
      );
      await update(pantry).replace(updatedItem);
    });
  }

}
