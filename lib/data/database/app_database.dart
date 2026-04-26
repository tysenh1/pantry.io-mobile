import "dart:io";
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
// import 'package:pantry_io_mobile/core/data/database/tables/allergens.dart';
import 'package:pantry_io_mobile/data/models/generic_names.dart';
// import 'package:pantry_io_mobile/core/data/database/tables/items.dart';
// import 'package:pantry_io_mobile/core/data/database/tables/item_allergens.dart';
// import 'package:pantry_io_mobile/core/data/database/tables/pantry.dart';
// import 'package:pantry_io_mobile/core/data/database/tables/recipe_ingredients.dart';
// import 'package:pantry_io_mobile/core/data/database/tables/recipes.dart';

part "app_database.g.dart";

LazyDatabase _openConnection() => LazyDatabase(() async {
  // Global function
  final dbFolder = await getApplicationDocumentsDirectory();
  final file = File(path.join(dbFolder.path, 'pantry_app.db'));
  return NativeDatabase.createInBackground(file);
});

@DriftDatabase(tables: [GenericNames])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Fixed: QueryExecutor + async
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
