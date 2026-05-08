import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/ui/widgets/recipe_add_widget.dart';

class RecipeAddScreen extends StatelessWidget {
  const RecipeAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: RecipeAddWidget());
  }
}
