import 'package:flutter/foundation.dart';
import 'package:pantry_io_mobile/core/storage/storage_service.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';

enum AppPhase {
  loading,
  onboarding,
  app,
}

class AppState extends ChangeNotifier {
  final AppDatabase db;
  final StorageService storage;

  AppState({
    required this.db,
    required this.storage
  });

  AppPhase _phase = AppPhase.loading;
  AppPhase get phase => _phase;

  bool _llmConnected = false;
  bool get isLLMConnected => _llmConnected;

  bool get isLoading => _phase == AppPhase.loading;
  bool get isOnboarding => _phase == AppPhase.onboarding;
  bool get isAppReady => _phase == AppPhase.app;

  Future<void> initialize() async {
    final onboardingComplete = await storage.isOnboardingComplete();
    final llmConnected = await storage.isLLMConnected();

    _llmConnected = llmConnected;

    _phase = onboardingComplete
        ? AppPhase.app
        : AppPhase.onboarding;

    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    await storage.setOnboardingComplete(true);
    _phase = AppPhase.app;
    notifyListeners();
  }

  Future<void> restartOnboarding() async {
    await storage.setOnboardingComplete(false);

    _phase = AppPhase.onboarding;
    notifyListeners();
  }

  Future<void> setIsLLMConnected(bool value) async {
    await storage.setIsLLMConnected(value);

    _llmConnected = value;
    notifyListeners();
  }

}
