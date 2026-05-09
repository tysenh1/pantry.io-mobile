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
              id: Value(1),
              name: 'First Generic Name',
              primaryUnit: 'g',
              weightPerPiece: 20,
            ),
            GenericNamesCompanion.insert(
              id: Value(2),
              name: 'Second Generic Name',
              primaryUnit: 'g',
              weightPerPiece: 400,
            ),
            GenericNamesCompanion.insert(
              id: Value(3),
              name: 'Third Generic Name',
              primaryUnit: 'g',
              weightPerPiece: 300,
            ),
          ]);
        });

        await batch((batch) {
          batch.insertAll(pantry, [
            PantryCompanion.insert(
              id: Value(1),
              genericNameId: 1,
              quantity: Value(5000),
            ),
            PantryCompanion.insert(
              id: Value(2),
              genericNameId: 2,
              quantity: Value(2000),
            ),
            PantryCompanion.insert(
              id: Value(3),
              genericNameId: 3,
              quantity: Value(4),
            ),
          ]);
        });

        final recipeId = await into(recipes).insert(
          RecipesCompanion(
            name: Value('Test Recipe'),
            instructions: Value('Test'),
            tags: const Value('this,is,a,test'),
          ),
        );

        await into(recipeIngredients).insert(
          RecipeIngredientsCompanion.insert(
            recipeId: recipeId,
            pantryId: 2,
            quantityNeeded: 500,
            unit: 'g',
          ),
        );
      });
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
