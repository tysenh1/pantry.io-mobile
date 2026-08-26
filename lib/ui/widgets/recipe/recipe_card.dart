import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/core/utils/recipe_utils.dart';
import 'package:pantry_io_mobile/domain/models/recipe_with_ingredients.dart';
import 'package:pantry_io_mobile/ui/widgets/recipe/recipe_dialog.dart';

class RecipeCard extends StatelessWidget {
  final RecipeWithIngredients recipe;
  final Color? color;
  final GlobalKey? cardKey;

  const RecipeCard({
    super.key,
    required this.recipe,
    this.color,
    this.cardKey
  });

  String _formatMissingIngredients(List<IngredientItem> missing) {
    if (missing.isEmpty) return '';

    final names = missing.map((e) => e.name).toList();

    if (names.length == 1) {
      return 'Missing ${names.first}';
    }

    if (names.length == 2) {
      return 'Missing ${names[0]} and ${names[1]}';
    }

    final allButLast = names.sublist(0, names.length - 1).join(', ');
    return 'Missing $allButLast, and ${names.last}';
  }


  @override
  Widget build(BuildContext context) {
    final List<IngredientItem> missingIngredients = recipe.ingredients.where((ing) => !isIngredientQuantitySufficient(ing)).toList();
    return Card(
      color: color ?? (recipe.isRecipeComplete ? Theme.of(context).colorScheme.secondaryContainer : Theme.of(context).colorScheme.errorContainer),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        key: cardKey,
        title: Text(
          recipe.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: recipe.isRecipeComplete
            ? Text(recipe.formattedTagString, maxLines: 1, overflow: TextOverflow.ellipsis)
            : Text(_formatMissingIngredients(missingIngredients), maxLines: 1, overflow: TextOverflow.ellipsis),
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
                    )
                )
            );
        },
      ),
    );
  }
}
