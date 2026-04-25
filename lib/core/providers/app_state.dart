import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  bool _isLLMConnected = false;

  bool get isLLMConnected => _isLLMConnected;

  void setLLMConnected(bool connected) {
    _isLLMConnected = connected;
    notifyListeners();
  }
}
