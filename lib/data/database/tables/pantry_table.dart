import "package:drift/drift.dart";
import "package:pantry_io_mobile/data/database/tables/generic_names_table.dart";

class Pantry extends Table {
  IntColumn get id => integer()();
  IntColumn get genericNameId => integer().unique().references(
    GenericNames,
    #id,
    onDelete: KeyAction.cascade,
  )();
  RealColumn get quantity => real().withDefault(const Constant(0.0))();
  BoolColumn get isStaple => boolean().withDefault(const Constant(false))();
  RealColumn get weightPerPiece => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
