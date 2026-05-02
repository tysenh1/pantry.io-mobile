import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/data/models/ui/ingredient_input.dart';
import 'package:pantry_io_mobile/data/models/ui/pantry_generic_name_response.dart';

class RecipeAddWidget extends StatefulWidget {
  const RecipeAddWidget({super.key});

  @override
  State<RecipeAddWidget> createState() => _RecipeAddWidgetState();
}

class _RecipeAddWidgetState extends State<RecipeAddWidget> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _tagsController = TextEditingController();

  List<IngredientInput> _ingredients = [IngredientInput()];

  // Mocked generic names fetch data
  List<PantryGenericNameResponse> _genericNames = [];

  @override
  void initState() {
    super.initState();
    _fetchGenericNames();
  }

  // function to call db for generic names, has static data right now
  void _fetchGenericNames() async {
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _ingredients = [];
      _genericNames = [
        PantryGenericNameResponse(
          pantryId: 'someUUID',
          genericNameId: 'someUUID',
          weightPerPiece: 5,
          name: 'First Generic Name',
          primaryUnit: 'g',
        ),
        PantryGenericNameResponse(
          pantryId: 'someOtherUUID',
          genericNameId: 'someOtherUUID',
          weightPerPiece: 10,
          name: 'Second Generic Name',
          primaryUnit: 'g',
        ),
      ];
    });
  }

  void _addIngredient() {
    setState(() => _ingredients.add(IngredientInput()));
  }

  void _handleSubmit() {
    try {
      if (_nameController.text.isEmpty ||
          _instructionsController.text.isEmpty) {
        throw Exception('Name and Instructions fields cannot be empty.');
      }
      for (var ing in _ingredients) {
        print(ing.toString());
        if (ing.unit.isEmpty ||
            ing.quantityNeeded == 0 ||
            ing.selectedNameIndex != null) {
          throw Exception('Ingredients must have valid data.');
        }
      }
      _showSuccessModal();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void _showSuccessModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success!'),
        content: Text("${_nameController.text} has been added!"),
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
      appBar: AppBar(title: const Text("Add Recipe")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _instructionsController,
              decoration: const InputDecoration(labelText: "Instructions"),
              maxLines: 4,
            ),
            TextField(
              controller: _tagsController,
              decoration: const InputDecoration(labelText: "Tags"),
            ),
            const Divider(height: 40),
            const Text(
              "Ingredients",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            ..._ingredients.map((ing) {
              return Column(
                children: [
                  DropdownButton<int>(
                    value: ing.selectedNameIndex,
                    items: _genericNames.asMap().entries.map((entry) {
                      int idx = entry.key;
                      var data = entry.value;

                      return DropdownMenuItem<int>(
                        value: idx,
                        child: Text(data.name),
                      );
                    }).toList(),
                    onChanged: (int? newIndex) {
                      if (newIndex == null) return;

                      setState(() {
                        ing.selectedNameIndex = newIndex;

                        final selectedData = _genericNames[newIndex];

                        ing.pantryId = selectedData.pantryId;
                        ing.unitController.text = selectedData.primaryUnit;
                      });
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: ing.qtyController,
                          decoration: const InputDecoration(
                            labelText: "Quantity",
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: ing.unitController,
                          decoration: const InputDecoration(labelText: "Unit"),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addIngredient,
              child: const Text("Add Ingredient"),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: _handleSubmit,
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
