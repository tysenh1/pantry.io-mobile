import "package:drift/drift.dart";
import "package:pantry_io_mobile/data/database/tables/allergens_table.dart";
import "package:pantry_io_mobile/data/database/tables/items_table.dart";

class ItemAllergens extends Table {
  IntColumn get itemId =>
      integer().references(Items, #id, onDelete: KeyAction.cascade)();
  IntColumn get allergenId =>
      integer().references(Allergens, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {itemId, allergenId};
}
