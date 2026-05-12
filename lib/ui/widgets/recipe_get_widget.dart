import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/data/models/db/browse_recipes_item.dart';
import 'package:pantry_io_mobile/ui/widgets/recipe_card.dart';

class RecipeGetWidget extends StatefulWidget {
  const RecipeGetWidget({super.key});

  @override
  State<RecipeGetWidget> createState() => _RecipeGetWidgetState();
}

class _RecipeGetWidgetState extends State<RecipeGetWidget> {
  @override
  Widget build(BuildContext context) {
    final db = AppDatabase.instance;

    return Scaffold(
      appBar: AppBar(title: const Text("Cookable Recipes")),
      body: StreamBuilder<List<RecipeBrowseItem>>(
        stream: db.watchAllRecipes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No recipes you can cook right now."),
            );
          }

          final recipes = snapshot.data!;

          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return RecipeCard(recipe: recipe);
            },
          );
        },
      ),
    );
  }
}
