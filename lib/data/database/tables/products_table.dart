import "package:drift/drift.dart";
import "package:pantry_io_mobile/data/database/tables/generic_names_table.dart";

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get barcode => text().unique()();
  TextColumn get productName => text()();
  IntColumn get genericNameId =>
      integer().references(GenericNames, #id, onDelete: KeyAction.cascade)();
  RealColumn get unitSize => real()();
  TextColumn get unitType => text()();

  @override
  Set<Column> get primaryKey => {id};
}
