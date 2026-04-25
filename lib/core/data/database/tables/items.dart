import "package:drift/drift.dart";
import "package:pantry_io_mobile/core/data/database/tables/generic_names.dart";

class Items extends Table {
  TextColumn get id => text()();
  TextColumn get barcode => text().unique()();
  TextColumn get productName => text()();
  TextColumn get genericNameId =>
      text().references(GenericNames, #id, onDelete: KeyAction.cascade)();
  IntColumn get unitSize => integer()();
  TextColumn get unitType => text()();
}
