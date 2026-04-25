import "package:drift/drift.dart";
import "package:pantry_io_mobile/core/data/database/tables/generic_names.dart";

class Pantry extends Table {
  TextColumn get id => text()();
  TextColumn get genericNameId => text().unique().references(
    GenericNames,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get quantity => integer().withDefault(const Constant(0))();
  BoolColumn get isStaple => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
