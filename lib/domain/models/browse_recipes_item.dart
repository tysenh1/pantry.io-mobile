import 'dart:convert';

class RecipeBrowseItem {
  final int id;
  final String name;
  final String? tags;
  final String instructions;
  final List<IngredientItem> ingredients;

  RecipeBrowseItem({
    required this.id,
    required this.name,
    this.tags,
    required this.instructions,
    required this.ingredients,
  });

  factory RecipeBrowseItem.fromRow(dynamic row) {
    final List<dynamic> jsonList = jsonDecode(row.read<String>('ingredients'));
    print(row.read<String>('instructions'));

    return RecipeBrowseItem(
      id: row.read<int>('id'),
      name: row.read<String>('name'),
      tags: row.read<String?>('tags'),
      instructions: row.read<String>('instructions'),
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
      quantityNeeded: (json['quantityNeeded'] as num).toDouble(),
      ingredientUnit: json['ingredientUnit'] as String,
      pantryQuantity: json['pantryQuantity'] as int,
      primaryUnit: json['primaryUnit'] as String,
    );
  }
}
