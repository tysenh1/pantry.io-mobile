import 'package:flutter/foundation.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';

class AppState extends ChangeNotifier {
  bool _isLLMConnected = false;
  final AppDatabase db;

  AppState({required this.db});

  bool get isLLMConnected => _isLLMConnected;

  void setLLMConnected(bool connected) {
    _isLLMConnected = connected;
    notifyListeners();
  }

  Future<void> cookRecipe(int recipeId) async {
    try {
      await db.pantryDao.subtractRecipeIngredientQuantities(recipeId);

      notifyListeners();
    } catch (e) {
      debugPrint("Error cooking recipe: ${e}");
    }
  }
}
