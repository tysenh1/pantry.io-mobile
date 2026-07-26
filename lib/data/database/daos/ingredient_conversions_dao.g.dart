// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_conversions_dao.dart';

// ignore_for_file: type=lint
mixin _$IngredientConversionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $GenericNamesTable get genericNames => attachedDatabase.genericNames;
  $IngredientConversionsTable get ingredientConversions =>
      attachedDatabase.ingredientConversions;
  IngredientConversionsDaoManager get managers =>
      IngredientConversionsDaoManager(this);
}

class IngredientConversionsDaoManager {
  final _$IngredientConversionsDaoMixin _db;
  IngredientConversionsDaoManager(this._db);
  $$GenericNamesTableTableManager get genericNames =>
      $$GenericNamesTableTableManager(_db.attachedDatabase, _db.genericNames);
  $$IngredientConversionsTableTableManager get ingredientConversions =>
      $$IngredientConversionsTableTableManager(
        _db.attachedDatabase,
        _db.ingredientConversions,
      );
}
