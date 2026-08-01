import 'package:fuzzy/fuzzy.dart';
import 'package:intl/intl.dart';
import 'package:pantry_io_mobile/domain/models/recipe_history_with_ingredients.dart';

bool isSameDay(DateTime currentDate, DateTime previousDate) {
  return currentDate.year == previousDate.year && currentDate.month == previousDate.month && currentDate.day == previousDate.day;
}

String formatDate(DateTime date) {
    final now = DateTime.now();
    if (isSameDay(date, now)) return 'Today';
    if (isSameDay(date, now.subtract(const Duration(days: 1)))) return 'Yesterday';

    final String month = DateFormat('MMMM').format(date);
    final int day = date.day;
    final int year = date.year;

    String suffix = 'th';
    if (!(day >= 11 && day <= 13)) {
      switch (day % 10) {
        case 1:
          suffix = 'st';
          break;
        case 2:
          suffix = 'nd';
          break;
        case 3:
          suffix = 'rd';
          break;
      }
    }

    return '$month $day$suffix, $year';
}

List<RecipeHistoryWithIngredients> filterRecipeHistoryByTags(
  List<RecipeHistoryWithIngredients> recipes,
  Set<String> tags,
) {
  return recipes.where((recipe) {
    return tags.every((tag) => recipe.tags?.contains(tag) ?? false);
  }).toList();
}

List<RecipeHistoryWithIngredients> filterRecipeHistoryBySearchQuery(
  List<RecipeHistoryWithIngredients> recipes,
  String searchQuery
) {
  final fuse = Fuzzy<RecipeHistoryWithIngredients>(
    recipes,
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

  final results = fuse.search(searchQuery);
  return results.map((r) => r.item).toList();
}