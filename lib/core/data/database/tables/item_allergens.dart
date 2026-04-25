import "package:drift/drift.dart";
import "package:pantry_io_mobile/core/data/database/tables/allergens.dart";
import "package:pantry_io_mobile/core/data/database/tables/items.dart";

class ItemAllergens extends Table {
  TextColumn get itemId =>
      text().references(Items, #id, onDelete: KeyAction.cascade)();
  TextColumn get allergenId =>
      text().references(Allergens, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {itemId, allergenId};
}
