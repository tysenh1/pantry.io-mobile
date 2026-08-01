import 'package:flutter/material.dart';

enum RecipeHistorySortOrder {
  dateDesc,
  dateAsc,
}

final recipeHistorySortOptions = const [
  DropdownMenuItem(value: RecipeHistorySortOrder.dateDesc, child: Text('Date (Newest First)')),
  DropdownMenuItem(value: RecipeHistorySortOrder.dateAsc, child: Text('Date (Oldest First)')),
];