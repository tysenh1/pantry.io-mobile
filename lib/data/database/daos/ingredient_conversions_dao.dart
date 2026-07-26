import 'package:drift/drift.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/data/database/tables/ingredient_conversions_table.dart';

part 'ingredient_conversions_dao.g.dart';

@DriftAccessor(tables: [IngredientConversions])
class IngredientConversionsDao extends DatabaseAccessor<AppDatabase> with _$IngredientConversionsDaoMixin {
  IngredientConversionsDao(AppDatabase db) : super(db);

  Future<double?> getConversionWeight(int genericNameId, String unit) async {
    final query = select(ingredientConversions)
        ..where((c) => c.genericNameId.equals(genericNameId))
        ..where((c) => c.unit.equals(unit));

    final row = await query.getSingleOrNull();

    return row?.gramWeight;
  }

  Future<Set<String>> getAvailableUnitConversions(int genericNameId) async {
    Set<String> units = {};

    final query = select(ingredientConversions)
        ..where((c) => c.genericNameId.equals(genericNameId));

    final rows = await query.get();

    for (final row in rows) {
      units.add(row.unit);
    }

    return units;
  }
}