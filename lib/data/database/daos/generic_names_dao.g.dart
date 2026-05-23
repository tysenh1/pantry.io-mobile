// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_names_dao.dart';

// ignore_for_file: type=lint
mixin _$GenericNamesDaoMixin on DatabaseAccessor<AppDatabase> {
  $GenericNamesTable get genericNames => attachedDatabase.genericNames;
  $PantryTable get pantry => attachedDatabase.pantry;
  GenericNamesDaoManager get managers => GenericNamesDaoManager(this);
}

class GenericNamesDaoManager {
  final _$GenericNamesDaoMixin _db;
  GenericNamesDaoManager(this._db);
  $$GenericNamesTableTableManager get genericNames =>
      $$GenericNamesTableTableManager(_db.attachedDatabase, _db.genericNames);
  $$PantryTableTableManager get pantry =>
      $$PantryTableTableManager(_db.attachedDatabase, _db.pantry);
}
