// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_dao.dart';

// ignore_for_file: type=lint
mixin _$RecipeDaoMixin on DatabaseAccessor<AppDatabase> {
  $RecipesTable get recipes => attachedDatabase.recipes;
  $GenericNamesTable get genericNames => attachedDatabase.genericNames;
  $PantryTable get pantry => attachedDatabase.pantry;
  $RecipeIngredientsTable get recipeIngredients =>
      attachedDatabase.recipeIngredients;
  $IngredientConversionsTable get ingredientConversions =>
      attachedDatabase.ingredientConversions;
  RecipeDaoManager get managers => RecipeDaoManager(this);
}

class RecipeDaoManager {
  final _$RecipeDaoMixin _db;
  RecipeDaoManager(this._db);
  $$RecipesTableTableManager get recipes =>
      $$RecipesTableTableManager(_db.attachedDatabase, _db.recipes);
  $$GenericNamesTableTableManager get genericNames =>
      $$GenericNamesTableTableManager(_db.attachedDatabase, _db.genericNames);
  $$PantryTableTableManager get pantry =>
      $$PantryTableTableManager(_db.attachedDatabase, _db.pantry);
  $$RecipeIngredientsTableTableManager get recipeIngredients =>
      $$RecipeIngredientsTableTableManager(
        _db.attachedDatabase,
        _db.recipeIngredients,
      );
  $$IngredientConversionsTableTableManager get ingredientConversions =>
      $$IngredientConversionsTableTableManager(
        _db.attachedDatabase,
        _db.ingredientConversions,
      );
}
