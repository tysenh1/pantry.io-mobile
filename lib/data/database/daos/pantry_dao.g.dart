// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pantry_dao.dart';

// ignore_for_file: type=lint
mixin _$PantryDaoMixin on DatabaseAccessor<AppDatabase> {
  $GenericNamesTable get genericNames => attachedDatabase.genericNames;
  $PantryTable get pantry => attachedDatabase.pantry;
  $RecipesTable get recipes => attachedDatabase.recipes;
  $RecipeIngredientsTable get recipeIngredients =>
      attachedDatabase.recipeIngredients;
  PantryDaoManager get managers => PantryDaoManager(this);
}

class PantryDaoManager {
  final _$PantryDaoMixin _db;
  PantryDaoManager(this._db);
  $$GenericNamesTableTableManager get genericNames =>
      $$GenericNamesTableTableManager(_db.attachedDatabase, _db.genericNames);
  $$PantryTableTableManager get pantry =>
      $$PantryTableTableManager(_db.attachedDatabase, _db.pantry);
  $$RecipesTableTableManager get recipes =>
      $$RecipesTableTableManager(_db.attachedDatabase, _db.recipes);
  $$RecipeIngredientsTableTableManager get recipeIngredients =>
      $$RecipeIngredientsTableTableManager(
        _db.attachedDatabase,
        _db.recipeIngredients,
      );
}
