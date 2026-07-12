import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/domain/models/browse_recipes_item.dart';
import 'package:pantry_io_mobile/ui/widgets/recipe/recipe_dialog.dart';
import 'package:pantry_io_mobile/ui/widgets/recipe_detail_widget.dart';

class RecipeCard extends StatelessWidget {
  final BrowseRecipeItem recipe;
  final Color? color;
  final VoidCallback onCook;

  const RecipeCard({
    super.key,
    required this.recipe,
    this.color,
    required this.onCook,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? Theme.of(context).colorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          recipe.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(recipe.tags ?? 'No tags', maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              clipBehavior: Clip.hardEdge,
              insetPadding: const EdgeInsets.all(32),
              child: RecipeDialog(
                recipe: recipe,
                onCook: onCook,
                onClose: () => Navigator.pop(context)
              )
            )
          );
        },
      ),
    );
  }
}
