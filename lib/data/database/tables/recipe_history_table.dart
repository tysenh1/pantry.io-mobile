import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:pantry_io_mobile/data/database/tables/recipes_table.dart';

class ConsumedIngredient {
  final String name;
  final double quantity;
  final String unit;

  ConsumedIngredient({
    required this.name,
    required this.quantity,
    required this.unit,
  });

  factory ConsumedIngredient.fromJson(Map<String, dynamic> json) {
    return ConsumedIngredient(
      name: json['name'] as String,
      quantity: json['quantity'] as double,
      unit: json['unit'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'quantity': quantity,
    'unit': unit
  };
}

class ConsumedIngredientListConverter
    extends TypeConverter<List<ConsumedIngredient>, String> {
  const ConsumedIngredientListConverter();

  @override
  List<ConsumedIngredient> fromSql(String fromDb) {
    final List<dynamic> json = jsonDecode(fromDb);
    return json.map((i) => ConsumedIngredient.fromJson(i)).toList();
  }

  @override
  String toSql(List<ConsumedIngredient> value) {
    return jsonEncode(value.map((i) => i.toJson()).toList());
  }
}

class RecipeHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get recipeId => integer().nullable().references(
    Recipes,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get name => text()();
  TextColumn get instructions => text()();
  TextColumn get tags => text().nullable()();
  RealColumn get multiplier => real().withDefault(const Constant(1.0))();
  DateTimeColumn get cookedAt => dateTime()();
  TextColumn get ingredientsConsumed => text().map(
    const ConsumedIngredientListConverter()
  )();
}