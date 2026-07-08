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
            padding: const EdgeInsets.all(20),
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
                        const SizedBox(height: 8),
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
                        const SizedBox(height: 8),
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
    // return DraggableScrollableSheet(
    //   initialChildSize: 0.85,
    //   minChildSize: 0.5,
    //   maxChildSize: 0.95,
    //   expand: false,
    //   builder: (context, scrollController) => Column(
    //     children: [
    //
    //       Container(
    //         width: double.infinity,
    //         padding: const EdgeInsets.all(24),
    //         color: Theme.of(context).colorScheme.primaryContainer,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               recipe.name,
    //               style: Theme.of(context).textTheme.displayLarge?.copyWith(
    //                 color: Theme.of(context).colorScheme.onTertiaryContainer,
    //               ),
    //             ),
    //             if (recipe.tagList.isNotEmpty) ...[
    //               const SizedBox(height: 8),
    //               AppTagCarousel(tags: recipe.tagList),
    //             ],
    //           ],
    //         ),
    //       ),
    //       // scrollable body
    //       Expanded(
    //         child: ListView(
    //           controller: scrollController,
    //           padding: const EdgeInsets.all(24),
    //           children: [
    //             Text(
    //               'Ingredients',
    //               style: Theme.of(context).textTheme.headlineMedium,
    //             ),
    //             const SizedBox(height: 12),
    //             ...recipe.ingredients.map((ingredient) => Padding(
    //               padding: const EdgeInsets.only(bottom: 8),
    //               child: Text(
    //                 '${ingredient.quantityNeeded} ${ingredient.ingredientUnit}',
    //                 style: Theme.of(context).textTheme.bodyLarge,
    //               ),
    //             )),
    //             const SizedBox(height: 24),
    //             Text(
    //               'Instructions',
    //               style: Theme.of(context).textTheme.headlineMedium,
    //             ),
    //             const SizedBox(height: 12),
    //             Text(
    //               recipe.instructions,
    //               style: Theme.of(context).textTheme.bodyLarge,
    //             ),
    //           ],
    //         ),
    //       ),
    //       // cook button pinned to bottom
    //       Padding(
    //         padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
    //         child: AppButton(
    //           label: 'Cook Recipe',
    //           onPressed: () {
    //             // cook logic here
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}