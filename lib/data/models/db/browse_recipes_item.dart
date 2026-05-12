import 'dart:convert';

class RecipeBrowseItem {
  final int id;
  final String name;
  final String? tags;
  final List<IngredientItem> ingredients;

  RecipeBrowseItem({
    required this.id,
    required this.name,
    this.tags,
    required this.ingredients,
  });

  factory RecipeBrowseItem.fromRow(dynamic row) {
    final List<dynamic> jsonList = jsonDecode(row.read<String>('ingredients'));

    return RecipeBrowseItem(
      id: row.read<int>('id'),
      name: row.read<String>('name'),
      tags: row.read<String?>('tags'),
      ingredients: jsonList.map((i) => IngredientItem.fromJson(i)).toList(),
    );
  }
}

class IngredientItem {
  final double quantityNeeded;
  final String ingredientUnit;
  final int pantryQuantity;
  final String primaryUnit;

  IngredientItem({
    required this.quantityNeeded,
    required this.ingredientUnit,
    required this.pantryQuantity,
    required this.primaryUnit,
  });

  factory IngredientItem.fromJson(Map<String, dynamic> json) {
    return IngredientItem(
      quantityNeeded: (json['needed'] as num).toDouble(),
      ingredientUnit: json['unit'] as String,
      pantryQuantity: json['pantry_quantity'] as int,
      primaryUnit: json['primary_unit'] as String,
    );
  }
}
