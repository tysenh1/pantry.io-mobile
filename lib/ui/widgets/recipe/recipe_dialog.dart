import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/domain/models/browse_recipes_item.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_button.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_tag_carousel.dart';

class RecipeDialog extends StatelessWidget {
  final BrowseRecipeItem recipe;
  final VoidCallback onCook;
  final VoidCallback onClose;
  const RecipeDialog({
    super.key,
    required this.recipe,
    required this.onCook,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Header Container ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 20, top: 16, right: 20, bottom: 12),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row of Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                            recipe.name,
                            style: Theme.of(context).textTheme.titleLarge
                        ),
                      ),
                      AppButton(
                          label: 'Cook',
                          onPressed: onCook,
                          size: AppButtonSize.small
                      ),
                    ],
                  ),
                  if (recipe.tagList.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    AppTagCarousel(tags: recipe.tagList)
                  ]
                ]
            ),
          ),
          // --- Scrollable Content ---
          Flexible(
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Ingredients',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold
                            )
                        ),
                        const SizedBox(height: 4),
                        ...recipe.ingredients.map((ingredient) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                                '${ingredient.quantityNeeded} ${ingredient.ingredientUnit}',
                                style: Theme.of(context).textTheme.bodyMedium
                            )
                        )),
                        const SizedBox(height: 8),
                        Text(
                            'Instructions',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold
                            )
                        ),
                        const SizedBox(height: 4),
                        Text(
                            recipe.instructions,
                            style: Theme.of(context).textTheme.bodyMedium
                        )
                      ]
                  )
              )
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton(
                  label: 'Close',
                  onPressed: onClose,
                  size: AppButtonSize.medium,
                  type: AppButtonType.secondary
                )
              ]
            )
          )
        ]
    );
  }
}