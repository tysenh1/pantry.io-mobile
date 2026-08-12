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
import 'package:pantry_io_mobile/ui/widgets/tutorial/tutorial_spotlight_card.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

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

  TutorialCoachMark? tutorialCoachMark;

  final RecipeFormModel _formModel = RecipeFormModel();

  List<GenericNameInfo> _genericNames = [];

  Set<String> tags = {};

  final _tagFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadGenericNames();

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
      if (widget.isTutorial) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showTutorial();
        });
      }
    }
  }

  void _showTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: Colors.black,
      opacityShadow: 0.75,
      hideSkip: false,
      alignSkip: Alignment.topRight,
      onFinish: () {
        print("Tutorial finished");
        widget.onTutorialNext?.call();
      },
      onSkip: () {
        print("Tutorial skipped");
        widget.onTutorialNext?.call();
        return true;
      },
    )..show(context: context);
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

  List<TargetFocus> _createTargets() {
    return [
      TargetFocus(
        identify: "recipe_info",
        keyTarget: _recipeKey,
        shape: ShapeLightFocus.RRect,
        radius: 16,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return TutorialSpotlightCard(
                title: 'Recipe Information',
                description: 'do something here idk bro',
                currentStep: 1,
                totalSteps: 3,
                onNext: () => controller.next(),
              );
            },
          ),
        ],
      ),
      TargetFocus(
        identify: "generic_name",
        keyTarget: _genericNameKey,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return TutorialSpotlightCard(
                title: 'Generic name dropdown',
                description: 'when the name is generic broooo',
                currentStep: 2,
                totalSteps: 3,
                onNext: () => controller.next(),
              );
            },
          ),
        ],
      ),
      TargetFocus(
        identify: "unit",
        keyTarget: _unitKey,
        shape: ShapeLightFocus.RRect,
        radius: 12,
        contents: [
          TargetContent(
            align: ContentAlign.top, // Flips above since it's lower on screen
            builder: (context, controller) {
              return TutorialSpotlightCard(
                title: 'unit',
                description: 'when you uhhhhh un in the uhh it uhhh I think',
                currentStep: 3,
                totalSteps: 3,
                onNext: () {
                  controller.next();
                  if (widget.onTutorialNext != null) {
                    widget.onTutorialNext!();
                  }
                },
              );
            },
          ),
        ],
      ),
    ];
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
                  key: _recipeKey,
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
                          AppDropdown<int>(
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
                            key: _genericNameKey,
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
                                child: AppDropdown<String>(
                                  key: _unitKey,
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