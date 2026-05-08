import "package:drift/drift.dart";
import "package:pantry_io_mobile/data/models/db/generic_names.dart";

class Pantry extends Table {
  IntColumn get id => integer()();
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
