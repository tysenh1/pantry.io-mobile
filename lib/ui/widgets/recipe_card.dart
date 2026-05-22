import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/domain/models/browse_recipes_item.dart';
import 'package:pantry_io_mobile/ui/widgets/recipe_detail_widget.dart';

class RecipeCard extends StatelessWidget {
  final RecipeBrowseItem recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          recipe.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(recipe.tags ?? 'No tags'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) =>
                RecipeDetailWidget(recipe: recipe),
          );
        },
      ),
    );
  }
}
