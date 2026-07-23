import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/domain/models/recipe_history_with_ingredients.dart';
import 'package:pantry_io_mobile/domain/models/recipe_with_ingredients.dart';
import 'package:pantry_io_mobile/ui/widgets/recipe/confirm_cook_sheet.dart';
import 'package:pantry_io_mobile/ui/widgets/recipe/recipe_dialog.dart';
import 'package:pantry_io_mobile/ui/widgets/recipe_history/recipe_history_dialog.dart';

class RecipeHistoryCard extends StatelessWidget {
  final RecipeHistoryWithIngredients recipe;
  final Color? color;

  const RecipeHistoryCard({
    super.key,
    required this.recipe,
    this.color,
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
        subtitle: Text(recipe.tagString, maxLines: 1, overflow: TextOverflow.ellipsis),
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
                    child: RecipeHistoryDialog(
                      recipe: recipe,
                    )
                )
            );
          }
      ),
    );
  }
}
