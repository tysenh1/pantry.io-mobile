import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/domain/models/recipe_with_ingredients.dart';
import 'package:pantry_io_mobile/ui/widgets/recipe/confirm_cook_sheet.dart';
import 'package:pantry_io_mobile/ui/widgets/recipe/recipe_dialog.dart';

class RecipeCard extends StatelessWidget {
  final RecipeWithIngredients recipe;
  final Color? color;

  const RecipeCard({
    super.key,
    required this.recipe,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("${recipe.name}");
    for (final ing in recipe.ingredients) {
      debugPrint("name: ${ing.name}, is quan ad: ${ing.pantryQuantity >= (ing.quantityNeeded * ing.gramWeight)}");
    }
    return Card(
      color: color ?? (recipe.isRecipeComplete ? Theme.of(context).colorScheme.secondaryContainer : Theme.of(context).colorScheme.errorContainer),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          recipe.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(recipe.formattedTagString, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: recipe.isRecipeComplete ? const Icon(Icons.chevron_right) : null,
        onTap: () {
          if (recipe.isRecipeComplete) {
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
          }
        },
      ),
    );
  }
}
