import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/core/constants/common_tags.dart';
import 'package:pantry_io_mobile/core/constants/get_recipe_sort_order.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/recipe_with_ingredients.dart';
import 'package:pantry_io_mobile/domain/services/get_recipe_service.dart';
import 'package:pantry_io_mobile/ui/screens/recipe_history_screen.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_button.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_card.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_chip.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_dropdown.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_header.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_switch_tile_button.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_tag_carousel.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_text_field.dart';
import 'package:pantry_io_mobile/ui/widgets/recipe/recipe_card.dart';
import 'package:provider/provider.dart';

class GetRecipeScreen extends StatefulWidget {
  const GetRecipeScreen({super.key});

  @override
  State<GetRecipeScreen> createState() => _GetRecipeScreenState();
}

class _GetRecipeScreenState extends State<GetRecipeScreen> {

  bool _areIncompleteRecipesShown = false;

  final Set<String> _selectedTags = {};

  String _searchQuery = "";

  late Stream<List<RecipeWithIngredients>> _recipeStream;

  GetRecipeSortOrder sortOrder = GetRecipeSortOrder.nameAsc;

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

    final db = context.read<AppDatabase>();
    _recipeStream = db.recipeDao.watchAllRecipes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: 'Browse Recipes'),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: AppButton(
              label: 'Open Cooking History',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RecipeHistoryScreen()),
              ),
              type: AppButtonType.secondary,
              )
            )
          ),
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
                      onChanged: (val)  {
                        setState(() {_searchQuery = val;});
                      }
                    ),
                    AppTagCarousel(
                      tags: commonTags,
                      mode: AppChipMode.selectable,
                      onSelect: handleTap,
                      selectedTags: _selectedTags,
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
                    ),
                    AppDropdown(
                      items: getRecipeSortOptions,
                      value: sortOrder,
                      onChanged: (GetRecipeSortOrder? newSortOrder) => setState(() {
                        sortOrder = newSortOrder!;
                      })
                    )
                  ]
                )
              )
            )
          ),
          StreamBuilder<List<RecipeWithIngredients>>(
            stream: _recipeStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return
                  const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator())
                  );
              }
              // if (snapshot.hasError) {
              //   debugPrint('stream error: ${snapshot.error}');
              //   debugPrint('stack trace: ${snapshot.stackTrace}');
              //   return SliverToBoxAdapter(
              //     child: Text('Error: ${snapshot.error}'),
              //   );
              // }
              if (snapshot.data!.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 32),
                      child: Text(
                        'No recipes match your search',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                        ),
                      )
                    )
                  )
                );
              }

              List<RecipeWithIngredients> displayedRecipes = snapshot.data!;

              displayedRecipes = GetRecipeService().process(
                recipes: displayedRecipes,
                sortOrder: sortOrder,
                searchQuery: _searchQuery,
                selectedTags: _selectedTags,
                showIncompleteRecipes: _areIncompleteRecipesShown
              );

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      return RecipeCard(recipe: displayedRecipes[i]);
                      // if (_areIncompleteRecipesShown) {
                      //   return RecipeCard(recipe: displayedRecipes[i]);
                      // } else {
                      //   if (displayedRecipes[i].isRecipeComplete == true) {
                      //     return RecipeCard(recipe: displayedRecipes[i]);
                      //   }
                      // }
                      // if (!_areIncompleteRecipesShown && displayedRecipes[i].isRecipeComplete == true) {
                      //   print("this recipe should be complete: ${displayedRecipes[i].name}");
                      //   return RecipeCard(recipe: displayedRecipes[i]);
                      // }
                      //
                      // print("this can be complete or incomplete: ${displayedRecipes[i].name}");
                      // return RecipeCard(recipe: displayedRecipes[i]);

                    },
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
