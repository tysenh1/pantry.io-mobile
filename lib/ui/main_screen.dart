import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/logic/providers/app_state.dart';
import 'package:pantry_io_mobile/ui/screens/chatbot_screen.dart';
import 'package:pantry_io_mobile/ui/screens/quick_add_screen.dart';
import 'package:pantry_io_mobile/ui/screens/recipe_add_screen.dart';
import 'package:pantry_io_mobile/ui/screens/scanner_screen.dart';
import 'package:pantry_io_mobile/ui/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:pantry_io_mobile/ui/widgets/bottom_nav.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) {
        final List<Widget> pages = [
          const RecipeAddScreen(),
          const QuickAddScreen(),
          if (appState.isLLMConnected) const ScannerScreen(),
          const ChatbotScreen(),
          const SettingsScreen(),
        ];

        if (currentIndex >= pages.length) {
          currentIndex = pages.isEmpty ? 0 : pages.length - 1;
        }

        return Scaffold(
          body: pages[currentIndex],
          bottomNavigationBar: AppBottomNav(
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
          ),
        );
      },
    );
  }
}
