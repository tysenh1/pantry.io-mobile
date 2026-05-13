import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/data/models/db/browse_recipes_item.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';

class RecipeDetailWidget extends StatelessWidget {
  final RecipeBrowseItem recipe;
  final AppDatabase db;

  const RecipeDetailWidget({super.key, required this.recipe, required this.db});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(recipe.name)),
          // IconButton(
          //   icon: const Icon(Icons.delete_outline, color: Colors.red),
          //   onPressed: () => _confirmCook(context),
          // ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            onPressed: () => _confirmCook(context),
            child: const Text("Cook"),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (recipe.tags != null) Chip(label: Text(recipe.tags!)),
            const Divider(),
            const Text(
              "Ingredients",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...recipe.ingredients.map(
              (ing) => Text("• ${ing.quantityNeeded} ${ing.ingredientUnit}"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Close"),
        ),
      ],
    );
  }

  void _confirmCook(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: const Text(
          "This will remove the ingredient quantities from your pantry.",
        ),
        title: const Text("Cook Recipe?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () async {
              await db.cookRecipe(recipe.id);

              if (context.mounted) Navigator.pop(ctx);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text("Cook", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
