import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/add_recipe.dart';
import 'package:pantry_io_mobile/domain/models/pantry_generic_name_response.dart';
import 'package:pantry_io_mobile/domain/models/tag.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_button.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_chip.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_dropdown.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_header.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_card.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_tag_carousel.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_text_field.dart';
import 'package:provider/provider.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
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

  void _handleSubmit() {
    if (!_formModel.isValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Some fields are missing values.")),
      );
      return;
    }

    final db = context.read<AppDatabase>();
    db.recipeDao.createRecipe(
      name: _formModel.nameController.text.trim(),
      instructions: _formModel.instructionsController.text.trim(),
      rawTags: _formModel.tagsController.text.trim(),
      ingredientCompanions: _formModel.getIngredientCompanions(),
    );

    _showSuccessModal();
  }

  void _showSuccessModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success!'),
        content: Text("${_formModel.nameController.text} has been added!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
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
      appBar: AppHeader(title: 'Add Recipe'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            AppCard(
              title: "Recipe Information",
              child: Column(
                spacing: 16,
                children: [
                  AppTextField(placeholder: 'Recipe Name', controller: _formModel.nameController),
                  AppTextField(placeholder: 'Instructions', controller: _formModel.instructionsController, isMultiLine: true),
                  if (tags.isNotEmpty)
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
                  AppTextField(
                    placeholder: 'Tags', controller: _formModel.tagsController
                  )
                ]
              )
            ),
            SizedBox(height: 20),
            AppCard(
              title: 'Ingredients',
              child: Column(
                spacing: 16,
                children: [
                  ..._formModel.ingredients.map((ing) {
                    return AppCard(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        spacing: 16,
                        children: [
                          AppDropdown(
                            items: _genericNames.asMap().entries.map((entry) {
                              int index = entry.key;
                              var data = entry.value;
                              return DropdownMenuItem<int>(
                                value: index,
                                child: Text(data.name)
                              );
                            }).toList(),
                            onChanged: (_) {},
                            placeholder: 'Generic Name',
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: AppTextField(placeholder: 'Quantity', controller: ing.qtyController, keyboardType: TextInputType.numberWithOptions(decimal: true))
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: AppTextField(placeholder: 'Unit', controller: ing.unitController)
                              ),
                            ]
                          )
                        ]
                      )
                    );
                  }),
                  AppButton(
                    label: 'Add Ingredient',
                    type: AppButtonType.secondary,
                    onPressed: _addIngredient,
                  ),
                ],
              )
            ),

            SizedBox(height: 20),
            AppButton(label: "Add Pantry Item", onPressed: () {}, type: AppButtonType.primary)
          ]
        )
      )
    );
  }
}