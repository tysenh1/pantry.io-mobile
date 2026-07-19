import 'package:drift/drift.dart';
import 'package:pantry_io_mobile/data/database/tables/recipes_table.dart';
import 'package:pantry_io_mobile/domain/models/consumed_ingredient.dart';

class RecipeHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get recipeId => integer().nullable().references(
    Recipes,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get recipeName => text()();
  TextColumn get instructions => text()();
  TextColumn get tags => text().nullable()();
  RealColumn get multiplier => real().withDefault(const Constant(1.0))();
  DateTimeColumn get cookedAt => dateTime()();
  TextColumn get ingredientsConsumed => text().map(
    const ConsumedIngredientListConverter()
  )();
}