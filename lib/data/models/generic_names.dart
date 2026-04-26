import "package:drift/drift.dart";

class GenericNames extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().unique()();
  TextColumn get primaryUnit => text()();
  IntColumn get weightPerPiece => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
