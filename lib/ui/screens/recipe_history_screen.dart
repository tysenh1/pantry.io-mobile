import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:pantry_io_mobile/core/constants/common_tags.dart';
import 'package:pantry_io_mobile/core/utils/history_utils.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/recipe_history_with_ingredients.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_button.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_card.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_chip.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_dropdown.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_header.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_tag_carousel.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_text_field.dart';
import 'package:pantry_io_mobile/ui/widgets/recipe/recipe_card.dart';
import 'package:pantry_io_mobile/ui/widgets/recipe_history/recipe_history_card.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class RecipeHistoryScreen extends StatefulWidget {
  const RecipeHistoryScreen({super.key});

  @override
  State<RecipeHistoryScreen> createState() => _RecipeHistoryScreenState();
}

class _RecipeHistoryScreenState extends State<RecipeHistoryScreen> {
  final Set<String> _selectedTags = {};
  String _searchQuery = "";

  void handleTap(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    Stream<List<RecipeHistoryWithIngredients>> recipeHistoryStream = db.recipeHistoryDao.watchAllRecipes();
    return Scaffold(
      appBar: AppHeader(title: 'Cooking History'),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
                child: AppCard(
                  title: 'Filter',
                  child: Column(
                  spacing: 16,
                  children: [
                    AppTextField(
                      placeholder: 'Search Cooking History',
                      onChanged: (val) => setState(() => _searchQuery = val)
                    ),
                    AppTagCarousel(
                      tags: commonTags,
                      mode: AppChipMode.selectable,
                      onSelect: handleTap,
                      selectedTags: _selectedTags,
                      alignment: Alignment.centerLeft,
                    ),
                    AppDropdown(items: [DropdownMenuItem(child: Text('thing 1'))], onChanged: (_) {})
                  ]
                )
              )
            )
          ),
          StreamBuilder<List<RecipeHistoryWithIngredients>>(
            stream: recipeHistoryStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return
                    const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator())
                    );
              }
              if (snapshot.data!.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 32),
                      child: Text(
                        'No recipes found',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                        ),
                      )
                    )
                  )
                );
              }

              List<RecipeHistoryWithIngredients> displayedRecipes = snapshot.data!;

              if (_searchQuery.isNotEmpty) {
                final fuse = Fuzzy<RecipeHistoryWithIngredients>(
                  displayedRecipes,
                  options: FuzzyOptions(
                    keys: [
                      WeightedKey(name: 'name', getter: (r) => r.name, weight: 1.0),
                      // Uncomment this codeblock if you want tags to count in the fuzzy search
                      // WeightedKey(
                      //   name: 'tags',
                      //   getter: (r) => r.tags ?? '',
                      //   weight: 0.7,
                      // ),
                    ],
                    threshold: 0.4,
                  ),
                );

                final results = fuse.search(_searchQuery);
                displayedRecipes = results.map((r) => r.item).toList();
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      final currentRecipe = displayedRecipes[i];

                      final bool showHeader = i == 0 ||
                        !isSameDay(currentRecipe.cookedAt, displayedRecipes[i - 1].cookedAt);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (showHeader)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                              child: Text(
                                formatDate(currentRecipe.cookedAt),
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                  // fontFamily: 'Nunito',
                                ),
                              ),
                            ),

                          RecipeHistoryCard(recipe: currentRecipe),
                        ],
                      );
                    },
                  childCount: displayedRecipes.length,
                ),
              );
            }
          )
        ],
      )
    );
  }
}