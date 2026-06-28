import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/add_recipe.dart';
import 'package:pantry_io_mobile/domain/models/pantry_generic_name_response.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_button.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_header.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_card.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: 'Add Recipe'),
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
                  AppButton(label: "Add Ingredient", onPressed: () {}, type: AppButtonType.secondary),
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