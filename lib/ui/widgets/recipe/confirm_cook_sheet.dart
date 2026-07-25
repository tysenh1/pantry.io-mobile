import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/core/utils/ingredient_utils.dart';
import 'package:pantry_io_mobile/core/utils/unit_converter.dart';
import 'package:pantry_io_mobile/domain/models/recipe_with_ingredients.dart';
import 'package:pantry_io_mobile/domain/services/recipe_service.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_button.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_switch_tile_button.dart';
import 'package:provider/provider.dart';

class ConfirmCookSheet extends StatefulWidget {
  final RecipeWithIngredients recipe;

  const ConfirmCookSheet({
    super.key,
    required this.recipe,
  });

  @override
  State<ConfirmCookSheet> createState() => _CookConfirmDialogState();

}

class _CookConfirmDialogState extends State<ConfirmCookSheet> {

  double _multiplier = 1.0;
  Set<int> usedIngredients = {};
  Set<int> optionalIngredients = {};
  bool canRecipeBeDoubled = true;

  @override
  void initState() {
    super.initState();
    for (final ing in widget.recipe.ingredients) {
      if (ing.isOptional == true) {
        optionalIngredients.add(ing.pantryId);
      } else {
        usedIngredients.add(ing.pantryId);
        if (!isIngredientQuantitySufficient(ing, 2.0)) {
          canRecipeBeDoubled = false;
        }
      }
    }
  }

  Future<void> _confirmCook(BuildContext context) async {
    final service = context.read<RecipeService>();
    final recipe = widget.recipe;
    debugPrint('${recipe.id}');
    final usedFullIngredients = recipe.ingredients
      .where((i) => usedIngredients.contains(i.pantryId)).toList();

    await service.cookRecipe(
      recipe.copyWith(ingredients: usedFullIngredients),
      _multiplier
    );

    if (context.mounted) {
      Navigator.of(context).popUntil((route) => route.isFirst);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${recipe.name} cooked!'),
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
        )
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final ingredients = widget.recipe.ingredients;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 20, top: 16, right: 20, bottom: 12),
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      'Cook ${widget.recipe.name}?',
                      style: Theme.of(context).textTheme.titleLarge
                    ),

                  IconButton(
                      icon: Icon(Icons.close, size: 28),
                      onPressed: Navigator.of(context).pop,
                    )
                ],
              ),
            ]
          )
        ),
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Adjust recipe size?'),
                    SegmentedButton<double>(
                      showSelectedIcon: false,
                      selected: {_multiplier},
                      onSelectionChanged: (Set<double> selection) {
                        final next = selection.first;
                        if (next != _multiplier) {
                          setState(() => _multiplier = selection.first);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return Theme.of(context).colorScheme.primary;
                          } else if (states.contains(WidgetState.disabled)) {
                            return Colors.grey.shade300;
                          }
                          return Theme.of(context).colorScheme.surface;
                        }),
                        foregroundColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return Colors.white;
                          } else if (states.contains(WidgetState.disabled)) {
                            return Colors.grey.shade600;
                          }
                          return Colors.black;
                        }),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 2, vertical: 20))

                      ),
                      segments: [
                        ButtonSegment(
                            value: 0.5,
                            label: Text('½x')
                        ),
                        ButtonSegment(
                            value: 1.0,
                            label: Text('1x')
                        ),
                        ButtonSegment(
                            value: 2.0,
                            label: Text('2x'),
                          enabled: canRecipeBeDoubled,
                        )
                      ],
                    )
                  ],
                ),

                // Required ingredients
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ingredients',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          'New Quantity',
                          style: Theme.of(context).textTheme.bodyMedium
                        )
                      ]
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // children: usedIngredients.where((pantryId) {
                      //   final ing = ingredients.firstWhere((ing)  => ing.pantryId == pantryId);
                      //   print(usedIngredients);
                      //   print(ing.pantryId);
                      //   print(ing.name);
                      //   final newQuantity = ing.pantryQuantity - (ing.quantityNeeded * _multiplier);
                      //   return newQuantity >= 0;
                      // }).map((pantryId) {
                      children: usedIngredients.map((pantryId) {
                        final ing = ingredients.firstWhere((ing) => ing.pantryId == pantryId);
                        final newQuantity = normalizeQuantity(ing.pantryQuantity, ing.pantryUnit) - normalizeQuantity((ing.quantityNeeded * _multiplier), ing.ingredientUnit);

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${ing.quantityNeeded * _multiplier} ${ing.ingredientUnit} - ${ing.name}',
                                  style: Theme.of(context).textTheme.bodyMedium
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    size: 14,
                                    color: Colors.black
                                  ),
                                )
                              ]
                            ),

                            Text(
                              '$newQuantity ${ing.ingredientUnit}',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: newQuantity > 0 ? Colors.green : Colors.red
                              )
                            )
                          ]
                        );
                      }).toList()
                    )
                  ]
                ),

                // Optional ingredients
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      'Optional Ingredients',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),

                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: optionalIngredients.map((pantryId) {
                        final ing = ingredients.firstWhere((ing) => ing.pantryId == pantryId);
                        final newQuantity = ing.pantryQuantity - (ing.quantityNeeded * _multiplier);
                        final isOn = usedIngredients.contains(pantryId);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              '${ing.quantityNeeded * _multiplier} ${ing.ingredientUnit} - ${ing.name}',
                              style: Theme.of(context).textTheme.bodyMedium
                            ),

                            AppSwitchTileButton(
                              value: isOn,
                              isDisabled: newQuantity < 0,
                              onChanged: (bool newValue) {
                                setState(() {
                                  if (newValue) {
                                    usedIngredients.add(pantryId);
                                  } else {
                                    usedIngredients.remove(pantryId);
                                  }
                                });
                              }
                            )
                          ]
                        );
                      }).toList()
                    )
                  ]
                ),

                SizedBox(height: 2),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppButton(
                      label: 'Cook',
                      fontWeight: FontWeight.bold,
                      onPressed: () => _confirmCook(context),
                      size: AppButtonSize.medium
                    )
                  ]
                ),

                SizedBox(height: 8),

              ]
            )
          )
        )
      ]
    );
  }
}