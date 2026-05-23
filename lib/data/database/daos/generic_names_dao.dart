import 'package:drift/drift.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/data/database/tables/generic_names_table.dart';
import 'package:pantry_io_mobile/data/database/tables/pantry_table.dart';

part 'generic_names_dao.g.dart';

@DriftAccessor(tables: [GenericNames, Pantry])
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
}