import "package:drift/drift.dart";

class Recipes extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get instructions => text()();
  TextColumn get tags => text()();

  @override
  Set<Column> get primaryKey => {id};
}
