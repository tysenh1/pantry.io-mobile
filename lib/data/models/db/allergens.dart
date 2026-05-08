import "package:drift/drift.dart";

class Allergens extends Table {
  TextColumn get id => integer()();
  TextColumn get name => text().unique()();

  @override
  Set<Column> get primaryKey => {id};
}
