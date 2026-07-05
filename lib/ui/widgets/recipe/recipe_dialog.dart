import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:pantry_io_mobile/domain/models/browse_recipes_item.dart';

class RecipeDialog extends StatelessWidget {
  final BrowseRecipeItem recipeItem;
  final VoidCallback onCook;
  final VoidCallback onClose;
  const RecipeDialog({
    super.key,
    required this.recipeItem,
    required this.onCook,
    required this.onClose,
  })

  Widget build(BuildContext context) {

  }
}