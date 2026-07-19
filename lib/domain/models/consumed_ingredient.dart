import 'dart:convert';

import 'package:drift/drift.dart';

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