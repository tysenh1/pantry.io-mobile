import "package:drift/drift.dart";

class Allergens extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();

  @override
  Set<Column> get primaryKey => {id};
}
