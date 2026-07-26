import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/data/database/tables/recipe_history_table.dart';
import 'package:pantry_io_mobile/domain/models/add_recipe.dart';
import 'package:pantry_io_mobile/domain/models/generic_name_info.dart';
import 'package:pantry_io_mobile/domain/models/recipe_history_with_ingredients.dart';
import 'package:pantry_io_mobile/domain/models/recipe_with_ingredients.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_button.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_card.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_chip.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_dropdown.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_header.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_tag_carousel.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_text_field.dart';
import 'package:pantry_io_mobile/ui/widgets/recipe/confirm_cook_sheet.dart';
import 'package:pantry_io_mobile/ui/widgets/recipe/recipe_dialog.dart';
import 'package:pantry_io_mobile/ui/widgets/recipe_history/recipe_history_dialog.dart';

class WidgetShowcaseScreen extends StatefulWidget {
  const WidgetShowcaseScreen({super.key});

  @override
  State<WidgetShowcaseScreen> createState() => _WidgetShowcaseScreenState();
}

class _WidgetShowcaseScreenState extends State<WidgetShowcaseScreen> {
  final _formKey = GlobalKey<FormState>();

  final RecipeFormModel _formModel = RecipeFormModel();

  // Mocked generic names fetch data
  List<GenericNameInfo> _genericNames = [];

  Set<String> tags = {};

  final Set<String> selectedTags = {};

  @override
  void initState() {
    super.initState();
    _fetchGenericNames();
  }

  @override
  void dispose() {
    _formModel.dispose();
    super.dispose();
  }

  void _addIngredient() {
    setState(() {
      _formModel.addIngredient();
    });
  }

  // function to call db for generic names, has static data right now
  void _fetchGenericNames() async {
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _genericNames = [
        GenericNameInfo(
          pantryId: 1,
          id: 4,
          name: 'First Generic Name',
          units: {'first unit', 'second unit'}
        ),
        GenericNameInfo(
          pantryId: 2,
          id: 5,
          name: 'Second Generic Name',
          units: {'third unit', 'fourth unit'}
        ),
      ];

      tags = {'Tag 1', 'Tag 2', 'Tag 3', 'Tag 4'};

    });
  }

  void handleTap(String tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags.add(tag);
      }
    });
  }

  void handleRemove(String tagToDelete) {
    setState(() {
      tags.removeWhere((tag) => tag == tagToDelete);
    });
  }

  RecipeWithIngredients recipe = RecipeWithIngredients(
      id: 1,
      name: "Recipe",
      instructions: "THESE ARE THE INSTRUCTIONS",
      isRecipeComplete: true,
      ingredients: [
        IngredientItem(pantryId: 1, quantityNeeded: 5, ingredientUnit: 'g', pantryQuantity: 500, pantryUnit: 'g', name: 'INGREDIETN NAME'),
        IngredientItem(pantryId: 2, quantityNeeded: 200, ingredientUnit: 'g', pantryQuantity: 200, pantryUnit: 'g', name: 'optional ingredient', isOptional: true)
      ],
      tags: {'Tag 1','Tag 2','Tag 3','Tag 4', 'Tag 5'}
  );

  RecipeHistoryWithIngredients recipeHistory = RecipeHistoryWithIngredients(
    id: 1,
    name: "History Recipe",
    instructions: "COOK THE RECIPE BRO",
    tags: {'Tag 1', 'Tag 2', 'Tag 3', 'Tag 4'},
    ingredientsConsumed: [
      ConsumedIngredient(name: "ing 1", quantity: 200, unit: 'g'),
      ConsumedIngredient(name: "ing 2", quantity: 20000000, unit: 'kg')
    ],
    multiplier: 2.0,
    cookedAt: DateTime(2026, 6, 12, 15, 34, 0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: 'Widget Showcase'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            AppCard(
              title: "Ingredients",
              action: Text("BUTTON"),
              child: Column(
                spacing: 16,
                children: [
                  AppTextField(placeholder: 'This is a single line'),
                  AppTextField(placeholder: 'this is a multiline', isMultiLine: true),
                  AppDropdown(
                    items: _genericNames.asMap().entries.map((entry) {
                      int idx = entry.key;
                      var data = entry.value;
                      return DropdownMenuItem<int>(
                        value: idx,
                        child: Text(data.name)
                      );
                    }).toList(),
                    onChanged: (_) {},
                    placeholder: 'Generic Names'
                  ),
                  // if (tags.isNotEmpty)
                  AppCard(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    padding: const EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(999),
                    child: AppTagCarousel(
                      tags: tags,
                      mode: AppChipMode.selectable,
                      onSelect: handleTap,
                      selectedTags: selectedTags,
                      alignment: Alignment.centerLeft
                    ),
                  ),
                  if (tags.isNotEmpty)
                  AppTagCarousel(
                    tags: tags,
                    mode: AppChipMode.selectable,
                    onSelect: handleTap,
                    selectedTags: selectedTags,
                  ),
                  if (tags.isNotEmpty)
                  AppTagCarousel(
                    tags: tags,
                    mode: AppChipMode.removable,
                    onRemoved: handleRemove,
                    selectedTags: selectedTags,
                  ),
                  AppButton(label: "Add Ingredient", onPressed: () {}, type: AppButtonType.secondary),
                  AppButton(
                    label: "Open Recipe Dialog",
                      onPressed: () {
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
                    type: AppButtonType.secondary
                  ),

                  AppButton(
                      label: "Open History Dialog",
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                clipBehavior: Clip.hardEdge,
                                insetPadding: const EdgeInsets.all(32),
                                child: RecipeHistoryDialog(
                                  recipe: recipeHistory,
                                )
                            )
                        );
                      },
                      type: AppButtonType.secondary
                  ),
                ]
              )
            ),
            AppButton(label: "Add Pantry Item", onPressed: () {}, type: AppButtonType.primary)
          ]
        )
      )
    );
  }
}