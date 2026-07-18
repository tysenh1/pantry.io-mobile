// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_dao.dart';

// ignore_for_file: type=lint
mixin _$ProductsDaoMixin on DatabaseAccessor<AppDatabase> {
  $GenericNamesTable get genericNames => attachedDatabase.genericNames;
  $ProductsTable get products => attachedDatabase.products;
  ProductsDaoManager get managers => ProductsDaoManager(this);
}

class ProductsDaoManager {
  final _$ProductsDaoMixin _db;
  ProductsDaoManager(this._db);
  $$GenericNamesTableTableManager get genericNames =>
      $$GenericNamesTableTableManager(_db.attachedDatabase, _db.genericNames);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db.attachedDatabase, _db.products);
}
