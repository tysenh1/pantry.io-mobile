import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService({
    SharedPreferencesAsync? preferences,
    FlutterSecureStorage? secureStorage,
  })  : _preferences = preferences ?? SharedPreferencesAsync(),
        _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final SharedPreferencesAsync _preferences;
  final FlutterSecureStorage _secureStorage;

  // ---------- Shared Preferences Values ---------
  Future<void> setOnboardingComplete(bool value) {
    return _preferences.setBool('onboarding_complete', value);
  }

  Future<bool> isOnboardingComplete() async {
    return await _preferences.getBool('onboarding_complete') ?? false;
  }


  // --------- Secure Storage Values ---------
  Future<void> saveOFFToken(String token) {
    return _secureStorage.write(
      key: 'offToken',
      value: token
    );
  }

  Future<String?> getOFFToken() {
    return _secureStorage.read(key: 'offToken');
  }

  Future<void> deleteOFFToken() {
    return _secureStorage.delete(key: 'offToken');
  }
}