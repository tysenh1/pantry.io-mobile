import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/domain/models/add_recipe.dart';
import 'package:pantry_io_mobile/domain/models/browse_recipes_item.dart';
import 'package:pantry_io_mobile/domain/models/pantry_generic_name_response.dart';
import 'package:pantry_io_mobile/ui/screens/add_recipe_screen.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_button.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_card.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_chip.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_dropdown.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_header.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_tag_carousel.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_text_field.dart';
import 'package:pantry_io_mobile/ui/widgets/recipe/recipe_dialog.dart';

class WidgetShowcaseScreen extends StatefulWidget {
  const WidgetShowcaseScreen({super.key});

  @override
  State<WidgetShowcaseScreen> createState() => _WidgetShowcaseScreenState();
}

class _WidgetShowcaseScreenState extends State<WidgetShowcaseScreen> {
  final _formKey = GlobalKey<FormState>();

  final RecipeFormModel _formModel = RecipeFormModel();

  // Mocked generic names fetch data
  List<PantryGenericNameResponse> _genericNames = [];

  List<Tag> tags = [];

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
        PantryGenericNameResponse(
          pantryId: 1,
          genericNameId: 4,
          weightPerPiece: 5,
          name: 'First Generic Name',
          primaryUnit: 'g',
        ),
        PantryGenericNameResponse(
          pantryId: 2,
          genericNameId: 5,
          weightPerPiece: 10,
          name: 'Second Generic Name',
          primaryUnit: 'g',
        ),
      ];

      tags = [
        (label: 'Tag 1'),
        (label: 'Tag 2'),
        (label: 'Tag 3')
      ];

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
      tags.removeWhere((tag) => tag.label == tagToDelete);
    });
  }

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
                      tags: tags.map((tag) {return tag.label;}).toList(),
                      mode: AppChipMode.selectable,
                      onSelect: handleTap,
                      selectedTags: selectedTags,
                      alignment: Alignment.centerLeft
                    ),
                  ),
                  if (tags.isNotEmpty)
                  AppTagCarousel(
                    tags: tags.map((tag) {return tag.label;}).toList(),
                    mode: AppChipMode.selectable,
                    onSelect: handleTap,
                    selectedTags: selectedTags,
                  ),
                  if (tags.isNotEmpty)
                  AppTagCarousel(
                    tags: tags.map((tag) {return tag.label;}).toList(),
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
                              recipe: BrowseRecipeItem(
                                id: 1,
                                name: "Recipe",
                                instructions: "THESE ARE THE INSTRUCTIONS",
                                ingredients: [
                                  IngredientItem(quantityNeeded: 5, ingredientUnit: 'g', pantryQuantity: 500, primaryUnit: 'g')
                                ],
                                tags: 'Tag 1,Tag 2,Tag 3,Tag 4, Tag 5'
                              ),
                              onCook: () {},
                              onClose: () => Navigator.pop(context)
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