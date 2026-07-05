import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/domain/models/browse_recipes_item.dart';
import 'package:pantry_io_mobile/data/repositories/app_state.dart';
import 'package:provider/provider.dart';

class RecipeDetailWidget extends StatelessWidget {
  final BrowseRecipeItem recipe;

  const RecipeDetailWidget({super.key, required this.recipe});

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
            const Divider(),
            const Text(
              "Instructions",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(recipe.instructions),
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
    final appState = Provider.of<AppState>(context, listen: false);
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
              await appState.cookRecipe(recipe.id);

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
