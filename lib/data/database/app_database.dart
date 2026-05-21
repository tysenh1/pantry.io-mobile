import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:pantry_io_mobile/data/database/daos/pantry_dao.dart';
import 'package:pantry_io_mobile/data/database/daos/recipe_dao.dart';
import 'package:pantry_io_mobile/data/db_seed_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'tables/generic_names_table.dart';
import 'tables/allergens_table.dart';
import 'tables/items_table.dart';
import 'tables/item_allergens_table.dart';
import 'tables/pantry_table.dart';
import 'tables/recipe_ingredients_table.dart';
import 'tables/recipes_table.dart';

part 'app_database.g.dart';

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
  daos: [PantryDao]
)
class AppDatabase extends _$AppDatabase {
  static final AppDatabase instance = AppDatabase._internal();
  AppDatabase._internal() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  PantryDao get pantryDao => PantryDao(this);
  RecipeDao get recipeDao => RecipeDao(this);

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await seedAllData(this);
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },);
}
