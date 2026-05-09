import "dart:io";
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:pantry_io_mobile/data/models/db/allergens.dart';
import 'package:pantry_io_mobile/data/models/db/generic_names.dart';
import 'package:pantry_io_mobile/data/models/db/items.dart';
import 'package:pantry_io_mobile/data/models/db/item_allergens.dart';
import 'package:pantry_io_mobile/data/models/db/pantry.dart';
import 'package:pantry_io_mobile/data/models/db/recipe_ingredients.dart';
import 'package:pantry_io_mobile/data/models/db/recipes.dart';
import 'package:pantry_io_mobile/data/models/dao/recipe_dao.dart';

part "app_database.g.dart";

LazyDatabase _openConnection() => LazyDatabase(() async {
  final dbFolder = await getApplicationDocumentsDirectory();
  final file = File(path.join(dbFolder.path, 'pantry_app.db'));
  return NativeDatabase.createInBackground(file, logStatements: true);
});

@DriftDatabase(
  tables: [
    GenericNames,
    Allergens,
    Items,
    ItemAllergens,
    Pantry,
    RecipeIngredients,
    Recipes,
  ],
  daos: [RecipeDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();

      await transaction(() async {
        await batch((batch) {
          batch.insertAll(genericNames, [
            GenericNamesCompanion.insert(
              name: 'First Generic Name',
              primaryUnit: 'g',
              weightPerPiece: 20,
            ),
            GenericNamesCompanion.insert(
              name: 'Second Generic Name',
              primaryUnit: 'g',
              weightPerPiece: 400,
            ),
            GenericNamesCompanion.insert(
              name: 'Third Generic Name',
              primaryUnit: 'g',
              weightPerPiece: 300,
            ),
          ]);
        });
      });
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
