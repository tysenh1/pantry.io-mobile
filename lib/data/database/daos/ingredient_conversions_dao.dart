import 'package:drift/drift.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/data/database/tables/ingredient_conversions_table.dart';
import 'package:pantry_io_mobile/data/database/tables/pantry_table.dart';
import 'package:pantry_io_mobile/domain/models/local_unit.dart';

part 'ingredient_conversions_dao.g.dart';

@DriftAccessor(tables: [IngredientConversions, Pantry])
class IngredientConversionsDao extends DatabaseAccessor<AppDatabase> with _$IngredientConversionsDaoMixin {
  IngredientConversionsDao(AppDatabase db) : super(db);

  Future<double> getConversionWeight(int genericNameId, String unit) async {
    final query = select(ingredientConversions)
        ..where((c) => c.genericNameId.equals(genericNameId))
        ..where((c) => c.unit.equals(unit));

    final row = await query.getSingle();

    return row.gramWeight;
  }

  Future<Map<int, LocalUnit>> getAvailableUnitConversions(int genericNameId) async {
    Map<int, LocalUnit> units = {};

    final query = select(ingredientConversions).join([
      innerJoin(pantry, pantry.genericNameId.equals(genericNameId))
    ])..where(ingredientConversions.genericNameId.equals(genericNameId));

    final rows = await query.get();

    for (final row in rows) {
      final conversion = row.readTable(ingredientConversions);
      final pantryRow = row.readTable(pantry);

      if (!units.keys.contains(conversion.id)) {
        units[-1] = LocalUnit(id: -1, name: pantryRow.unit, value: 1.0);
      }
      units[conversion.id] = LocalUnit(id: conversion.id, name: conversion.unit, value: conversion.gramWeight);
    }

    return units;
  }
}