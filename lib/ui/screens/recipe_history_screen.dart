import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/core/constants/common_tags.dart';
import 'package:pantry_io_mobile/core/constants/recipe_history_sort_order.dart';
import 'package:pantry_io_mobile/core/utils/recipe_history_utils.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/recipe_history_with_ingredients.dart';
import 'package:pantry_io_mobile/domain/services/recipe_history_service.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_card.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_chip.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_dropdown.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_header.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_tag_carousel.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_text_field.dart';
import 'package:pantry_io_mobile/ui/widgets/recipe_history/recipe_history_card.dart';
import 'package:pantry_io_mobile/ui/widgets/tutorial/tutorial_spotlight_card.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class RecipeHistoryScreen extends StatefulWidget {
  final bool isTutorial;
  final VoidCallback? onTutorialNext;
  const RecipeHistoryScreen({super.key, required this.isTutorial, this.onTutorialNext});

  @override
  State<RecipeHistoryScreen> createState() => _RecipeHistoryScreenState();
}

class _RecipeHistoryScreenState extends State<RecipeHistoryScreen> {
  final Set<String> _selectedTags = {};
  String _searchQuery = "";
  late Stream<List<RecipeHistoryWithIngredients>> _recipeHistoryStream;
  RecipeHistorySortOrder sortOrder = RecipeHistorySortOrder.dateDesc;
  TutorialCoachMark? tutorialCoachMark;

  final GlobalKey _filterKey = GlobalKey();
  final GlobalKey _recipeCardKey = GlobalKey();

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
    _recipeHistoryStream = db.recipeHistoryDao.watchAllRecipes();
    if (widget.isTutorial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showTutorial();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: Colors.black,
      opacityShadow: 0.75,
      hideSkip: false,
      alignSkip: Alignment.topRight,
      onFinish: () {
        widget.onTutorialNext?.call();
        Navigator.pop(context);
      },
      onSkip: () {
        widget.onTutorialNext?.call();
        return true;
      },
    )..show(context: context);
  }

  List<TargetFocus> _createTargets() {
    return [
      TargetFocus(
        identify: 'history_filter_info',
        keyTarget: _filterKey,
        shape: ShapeLightFocus.RRect,
        radius: 16,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return TutorialSpotlightCard(
                title: 'Filter Information',
                description: 'this is literally the same as the other one',
                currentStep: 1,
                totalSteps: 2,
                onNext: () => controller.next()
              );
            }
          )
        ]
      ),
      TargetFocus(
        identify: 'history_recipe_card',
        keyTarget: _recipeCardKey,
        shape: ShapeLightFocus.RRect,
        radius: 16,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return TutorialSpotlightCard(
                title: 'Recipe Card',
                description: 'this is also literally just the exact same as the one from before',
                currentStep: 2,
                totalSteps: 2,
                onNext: () {
                  tutorialCoachMark?.finish();
                }
              );
            }
          )
        ]
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: 'Cooking History'),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
                child: AppCard(
                  title: 'Filter',
                  key: _filterKey,
                  child: Column(
                  spacing: 16,
                  children: [
                    AppTextField(
                      placeholder: 'Search Cooking History',
                      onChanged: (val) {
                        setState(() {_searchQuery = val;});
                      }
                    ),
                    AppTagCarousel(
                      tags: commonTags,
                      mode: AppChipMode.selectable,
                      onSelect: handleTap,
                      selectedTags: _selectedTags,
                      alignment: Alignment.centerLeft,
                    ),
                    AppDropdown(
                      items: recipeHistorySortOptions,
                      value: sortOrder,
                      onChanged: (RecipeHistorySortOrder? newSortOrder) => setState(() {sortOrder = newSortOrder!;})
                    )
                  ]
                )
              )
            )
          ),
          StreamBuilder<List<RecipeHistoryWithIngredients>>(
            stream: _recipeHistoryStream,
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

              displayedRecipes = RecipeHistoryService().process(
                recipes: displayedRecipes,
                sortOrder: sortOrder,
                searchQuery: _searchQuery,
                selectedTags: _selectedTags
              );

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      final currentRecipe = displayedRecipes[i];

                      final bool showHeader = i == 0 ||
                        !isSameDay(currentRecipe.cookedAt, displayedRecipes[i - 1].cookedAt);

                      return Column(
                        key: i == 0 ? _recipeCardKey : null,
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