import "package:drift/drift.dart";
import "package:pantry_io_mobile/data/database/tables/generic_names_table.dart";

class Items extends Table {
  IntColumn get id => integer()();
  TextColumn get barcode => text().unique()();
  TextColumn get productName => text()();
  IntColumn get genericNameId =>
      integer().references(GenericNames, #id, onDelete: KeyAction.cascade)();
  IntColumn get unitSize => integer()();
  TextColumn get unitType => text()();
}
