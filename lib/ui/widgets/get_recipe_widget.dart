import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/browse_recipes_item.dart';
import 'package:pantry_io_mobile/ui/widgets/recipe_card.dart';
import 'package:provider/provider.dart';

class GetRecipeWidget extends StatefulWidget {
  const GetRecipeWidget({super.key});

  @override
  State<GetRecipeWidget> createState() => _GetRecipeWidgetState();
}

class _GetRecipeWidgetState extends State<GetRecipeWidget> {
  String _searchQuery = "";
  String? _selectedTag;

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cookable Recipes"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: const InputDecoration(hintText: "Search Recipes"),
                  onChanged: (val) => setState(() => _searchQuery = val),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ["Test1", "Test2", "Test3"].map((tag) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Text(tag),
                        selected: _selectedTag == tag,
                        onSelected: (selected) {
                          setState(() => _selectedTag = selected ? tag : null);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),

      body: StreamBuilder<List<BrowseRecipeItem>>(
        stream: db.recipeDao.watchAllRecipes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();

          List<BrowseRecipeItem> displayedRecipes = snapshot.data!;

          if (_searchQuery.isNotEmpty) {
            final fuse = Fuzzy<BrowseRecipeItem>(
              displayedRecipes,
              options: FuzzyOptions(
                keys: [
                  WeightedKey(name: 'name', getter: (r) => r.name, weight: 1.0),
                  WeightedKey(
                    name: 'tags',
                    getter: (r) => r.tags ?? '',
                    weight: 0.7,
                  ),
                ],
                threshold: 0.4,
              ),
            );

            final results = fuse.search(_searchQuery);
            displayedRecipes = results.map((r) => r.item).toList();
          }

          return ListView.builder(
            itemCount: displayedRecipes.length,
            itemBuilder: (context, i) =>
                RecipeCard(recipe: displayedRecipes[i]),
          );
        },
      ),
    );
  }
}
