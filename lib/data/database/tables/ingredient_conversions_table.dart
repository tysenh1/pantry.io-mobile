import 'package:drift/drift.dart';
import 'package:pantry_io_mobile/data/database/tables/generic_names_table.dart';

class IngredientConversions extends Table {
  IntColumn get id => integer()();
  IntColumn get genericNameId => integer().references(
    GenericNames,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get unit => text()();
  RealColumn get gramWeight => real()();

  @override
  Set<Column> get primaryKey => {id};
}