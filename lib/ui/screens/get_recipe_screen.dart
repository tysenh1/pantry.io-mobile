import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/browse_recipes_item.dart';
import 'package:pantry_io_mobile/domain/models/tag.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_card.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_chip.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_header.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_switch_tile_button.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_tag_carousel.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_text_field.dart';
import 'package:pantry_io_mobile/ui/widgets/common/recipe_card.dart';
import 'package:provider/provider.dart';

class GetRecipeScreen extends StatefulWidget {
  const GetRecipeScreen({super.key});

  @override
  State<GetRecipeScreen> createState() => _GetRecipeScreenState();
}

class _GetRecipeScreenState extends State<GetRecipeScreen> {
  late Stream<List<BrowseRecipeItem>> _recipesStream;

  bool _areIncompleteRecipesShown = false;
  List<Tag> tags = [(label: 'Tag 1'), (label: 'Tag 2'), (label: 'Tag 3')];

  final Set<String> selectedTags = {};

  String _searchQuery = "";

  void handleTap(String tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags.add(tag);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    final db = context.read<AppDatabase>();
    _recipesStream = db.recipeDao.watchAllRecipes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: 'Get Recipe'),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: AppCard(
                title: 'Filter',
                child: Column(
                  spacing: 16,
                  children: [
                    AppTextField(
                      placeholder: 'Search Recipes',
                      onChanged: (val) => setState(() => _searchQuery = val)
                    ),
                    AppTagCarousel(
                      tags: tags.map((tag) {return tag.label;}).toList(),
                      mode: AppChipMode.selectable,
                      onSelect: handleTap,
                      selectedTags: selectedTags,
                      alignment: Alignment.centerLeft
                    ),
                    AppSwitchTileButton(
                      value: _areIncompleteRecipesShown,
                      label: 'Show incomplete recipes?',
                      onChanged: (bool newValue) {
                        setState(() {
                          _areIncompleteRecipesShown = newValue;
                        });
                      }
                    )
                  ]
                )
              )
            )
          ),
          StreamBuilder<List<BrowseRecipeItem>>(
            stream: _recipesStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return
                  const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator())
                  );
              }

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

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, i) => RecipeCard(recipe: displayedRecipes[i], onCook: () {}),
                    childCount: displayedRecipes.length,
                ),
              );
            },
          ),
        ]
      )
    );
  }
}
