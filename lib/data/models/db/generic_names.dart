import "package:drift/drift.dart";

class GenericNames extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text().unique()();
  TextColumn get primaryUnit => text()();
  RealColumn get weightPerPiece => real()();

  @override
  Set<Column> get primaryKey => {id};
}
