import 'package:drift/drift.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/data/database/tables/generic_names_table.dart';
import 'package:pantry_io_mobile/data/database/tables/pantry_table.dart';
import 'package:pantry_io_mobile/domain/models/generic_name_info.dart';
import 'package:pantry_io_mobile/data/database/tables/ingredient_conversions_table.dart';

part 'generic_names_dao.g.dart';

@DriftAccessor(tables: [GenericNames, Pantry, IngredientConversions])
class GenericNamesDao extends DatabaseAccessor<AppDatabase> with _$GenericNamesDaoMixin {
  GenericNamesDao(AppDatabase db) : super(db);

  Future<List<GenericName>> getAllGenericNames() async {
    final query = select(genericNames);
    return query.get();
  }

  Future<GenericName?> getGenericNameByName(String incomingName) async {
    final query = select(genericNames)..where((tbl) => tbl.name.equals(incomingName.toLowerCase()));

    return await query.getSingleOrNull();
  }

  Future<List<GenericNameInfo>> getAllGenericNameInfo() async {
    final query = select(genericNames).join([
      innerJoin(ingredientConversions, genericNames.id.equalsExp(ingredientConversions.genericNameId)),
      innerJoin(pantry, genericNames.id.equalsExp(pantry.genericNameId))
    ]);

    final rows = await query.get();
    final Map<int, (String, Set<String>, int)> groupedByName = {};

    for (final row in rows) {
      final id = row.read(genericNames.id)!;
      final name = row.read(genericNames.name)!;
      final pantryId = row.read(pantry.id)!;
      final pantryUnit = row.read(pantry.unit);
      final conversion = row.readTable(ingredientConversions);

      if (!groupedByName.containsKey(id)) {
        groupedByName[id] = (name, {pantryUnit!}, pantryId);
      }

      groupedByName[id]!.$2.add(conversion.unit);
    }

    return groupedByName.entries.map((entry) {
      return GenericNameInfo(
        id: entry.key,
        name: entry.value.$1,
        units: entry.value.$2,
        pantryId: entry.value.$3
      );
    }).toList();
  }
}