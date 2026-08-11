import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/add_recipe.dart';
import 'package:pantry_io_mobile/domain/models/generic_name_info.dart';
import 'package:pantry_io_mobile/domain/models/ingredient_input.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_button.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_chip.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_dropdown.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_header.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_card.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_tag_carousel.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_text_field.dart';
import 'package:pantry_io_mobile/ui/widgets/tutorial/tutorial_spotlight.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

class AddRecipeScreen extends StatefulWidget {
  final bool isTutorial;
  final VoidCallback? onTutorialNext;
  const AddRecipeScreen({super.key, required this.isTutorial, this.onTutorialNext});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final GlobalKey _recipeKey = GlobalKey();
  final GlobalKey _genericNameKey = GlobalKey();
  final GlobalKey _unitKey = GlobalKey();

  final RecipeFormModel _formModel = RecipeFormModel();

  List<GenericNameInfo> _genericNames = [];

  Set<String> tags = {};

  final _tagFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadGenericNames();
    if (widget.isTutorial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context).startShowCase([
          _recipeKey,
          _genericNameKey,
          _unitKey
        ]);
      });
    }
  }

  @override
  void dispose() {
    _formModel.dispose();
    _tagFocusNode.dispose();
    super.dispose();
  }

  void _addIngredient() {
    setState(() {
      _formModel.addIngredient();
    });
  }

  // function to call db for generic names, has static data right now
  Future<void> _loadGenericNames() async {
    final db = Provider.of<AppDatabase>(context, listen: false);
    final allGenericNames = await db.genericNamesDao.getAllGenericNameInfo();

    if (mounted) {
      setState(() {
        _genericNames = allGenericNames;
      });
    }
  }

  void _onGenericNameChanged(IngredientInput ing, int? newId) async {
    if (newId == null) return;

    final selectedName = _genericNames.firstWhere((name) => name.id == newId);

    ing.selectedNameId = newId;
    ing.pantryId = selectedName.pantryId;
    ing.genericNameId = selectedName.id;

    final db = context.read<AppDatabase>();
    final conversions = await db.ingredientConversionsDao.getAvailableUnitConversions(selectedName.id);

    setState(() {
      ing.availableUnits = conversions.values.map((unit) => unit.name).toSet();
      ing.selectedUnit = ing.availableUnits.first;
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
      tags: tags,
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


  void handleRemove(String tagToDelete) {
    setState(() {
      tags.removeWhere((tag) => tag == tagToDelete);
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
            TutorialSpotlight(
              isTutorial: widget.isTutorial,
              showcaseKey: _recipeKey,
              title: 'Recipe Information',
              description: 'do something here idk bro',
              currentStep: 1,
              totalSteps: 3,
              child: AppCard(
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
                                tags: tags,
                                mode: AppChipMode.removable,
                                onRemoved: handleRemove,
                                alignment: Alignment.centerLeft
                            ),
                          ),
                        AppTextField(
                          placeholder: 'Tags', controller: _formModel.tagsController, focusNode: _tagFocusNode, textInputAction: TextInputAction.done, onSubmitted: (val) {
                          final trimmed = val.trim();
                          if (trimmed.isNotEmpty) {
                            setState(() {
                              tags.add(trimmed);
                              _formModel.tagsController.clear();
                            });
                            _tagFocusNode.requestFocus();
                          }
                        },
                        )
                      ]
                  )
              ),
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
                          TutorialSpotlight(
                            isTutorial: widget.isTutorial,
                            showcaseKey: _genericNameKey,
                            title: 'Generic name dropdown',
                            currentStep: 2,
                            totalSteps: 3,
                            description: 'when the name is generic broooo',
                            child: AppDropdown<int>(
                              value: ing.selectedNameId,
                              items: _genericNames.asMap().entries.map((entry) {
                                int id = entry.value.id;
                                var data = entry.value;
                                return DropdownMenuItem<int>(
                                  value: id,
                                  child: Text(data.name),
                                );
                              }).toList(),
                              onChanged: (int? newId) => _onGenericNameChanged(ing, newId),
                              placeholder: 'Generic Name',
                            ),
                          ),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: AppTextField(
                                  placeholder: 'Quantity',
                                  controller: ing.qtyController,
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                ),
                              ),
                              const SizedBox(width: 16),

                              Expanded(
                                child: TutorialSpotlight(
                                  isTutorial: widget.isTutorial,
                                  showcaseKey: _unitKey,
                                  title: 'unit',
                                  currentStep: 3,
                                  totalSteps: 3,
                                  description: 'when you uhhhhh un in the uhh it uhhh I think',
                                  onTargetClick: () {
                                    if (widget.onTutorialNext != null) {
                                      widget.onTutorialNext!();
                                    }
                                  },

                                  child: AppDropdown<String>(
                                    value: ing.selectedUnit,
                                    items: ing.availableUnits.map((unit) {
                                      return DropdownMenuItem<String>(
                                        value: unit,
                                        child: Text(unit),
                                      );
                                    }).toList(),
                                    onChanged: ing.availableUnits.isEmpty
                                        ? null
                                        : (String? newUnit) {
                                      setState(() {
                                        ing.selectedUnit = newUnit;
                                      });
                                    },
                                    placeholder: 'Unit',
                                  ),
                                ),
                              ),

                            ],
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
            AppButton(label: "Add Recipe", onPressed: _handleSubmit, type: AppButtonType.primary)
          ]
        )
      )
    );
  }
}