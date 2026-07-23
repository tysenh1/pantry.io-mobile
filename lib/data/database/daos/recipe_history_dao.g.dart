// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_history_dao.dart';

// ignore_for_file: type=lint
mixin _$RecipeHistoryDaoMixin on DatabaseAccessor<AppDatabase> {
  $RecipesTable get recipes => attachedDatabase.recipes;
  $RecipeHistoryTable get recipeHistory => attachedDatabase.recipeHistory;
  RecipeHistoryDaoManager get managers => RecipeHistoryDaoManager(this);
}

class RecipeHistoryDaoManager {
  final _$RecipeHistoryDaoMixin _db;
  RecipeHistoryDaoManager(this._db);
  $$RecipesTableTableManager get recipes =>
      $$RecipesTableTableManager(_db.attachedDatabase, _db.recipes);
  $$RecipeHistoryTableTableManager get recipeHistory =>
      $$RecipeHistoryTableTableManager(_db.attachedDatabase, _db.recipeHistory);
}
