import "dart:io";
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:pantry_io_mobile/data/db_seed_data.dart';
import 'package:pantry_io_mobile/domain/models/browse_recipes_item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:pantry_io_mobile/data/database/tables/allergens_table.dart';
import 'package:pantry_io_mobile/data/database/tables/generic_names_table.dart';
import 'package:pantry_io_mobile/data/database/tables/items_table.dart';
import 'package:pantry_io_mobile/data/database/tables/item_allergens_table.dart';
import 'package:pantry_io_mobile/data/database/tables/pantry_table.dart';
import 'package:pantry_io_mobile/data/database/tables/recipe_ingredients_table.dart';
import 'package:pantry_io_mobile/data/database/tables/recipes_table.dart';
import 'package:pantry_io_mobile/data/database/daos/recipe_dao.dart';
import 'package:pantry_io_mobile/core/utils/unit_converter.dart';

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
  static final AppDatabase instance = AppDatabase();

  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<RecipeBrowseItem>> watchAllRecipes() {
    return customSelect(
      '''
      SELECT r.*,
        (SELECT json_group_array(
          json_object(
            'quantityNeeded', ri.quantity_needed,
            'ingredientUnit', ri.unit,
            'pantryQuantity', p.quantity,
            'primaryUnit', g.primary_unit
          )
        )
        FROM recipe_ingredients ri
        JOIN pantry p ON ri.pantry_id = p.id
        JOIN generic_names g ON p.generic_name_id = g.id
        WHERE ri.recipe_id = r.id) as ingredients
      FROM recipes r
      ''',
      readsFrom: {recipes, recipeIngredients, pantry, genericNames},
    ).watch().map((rows) {
      final recipesList = rows
          .map((row) => RecipeBrowseItem.fromRow(row))
          .toList();

      return filterCookableRecipes(recipesList);
    });
  }

  Future<void> cookRecipe(int recipeId) async {
    print("do something");
    return;
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();

      try {
        await seedAllData(this);
      } catch (e) {
        print("Seeding failed: $e");
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  List<RecipeBrowseItem> filterCookableRecipes<T>(
    List<RecipeBrowseItem> recipes,
  ) {
    return recipes.where((recipe) {
      return recipe.ingredients.every((ing) {
        return normalizeQuantity(
              ing.pantryQuantity.toDouble(),
              ing.primaryUnit,
            ) >=
            normalizeQuantity(ing.quantityNeeded, ing.ingredientUnit);
      });
    }).toList();
  }
}
