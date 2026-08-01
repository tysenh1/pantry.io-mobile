import 'package:flutter/material.dart';

enum GetRecipeSortOrder {
  nameAsc,
  nameDesc
}

final getRecipeSortOptions = const [
  DropdownMenuItem(value: GetRecipeSortOrder.nameAsc, child: Text('A → Z')),
  DropdownMenuItem(value: GetRecipeSortOrder.nameDesc, child: Text('Z → A'))
];
