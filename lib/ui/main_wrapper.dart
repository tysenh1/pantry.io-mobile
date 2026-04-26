import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/logic/providers/app_state.dart';
import 'package:pantry_io_mobile/ui/screens/chatbot_screen.dart';
import 'package:pantry_io_mobile/ui/screens/quick_add_screen.dart';
import 'package:pantry_io_mobile/ui/screens/recipe_add_screen.dart';
import 'package:pantry_io_mobile/ui/screens/scanner_screen.dart';
import 'package:pantry_io_mobile/ui/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:pantry_io_mobile/ui/widgets/bottom_nav.dart';
import 'package:pantry_io_mobile/data/models/ui/nav_item.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  NavTab _currentTab = NavTab.addRecipe;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) {
        final allItems = [
          NavItem(
            id: NavTab.addRecipe,
            screen: const RecipeAddScreen(),
            item: const BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add Recipe',
            ),
          ),
          NavItem(
            id: NavTab.quickAdd,
            screen: const QuickAddScreen(),
            item: const BottomNavigationBarItem(
              icon: Icon(Icons.cookie),
              label: 'Quick Add',
            ),
          ),
          NavItem(
            id: NavTab.chatbot,
            screen: const ChatbotScreen(),
            item: const BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chatbot',
            ),
            showIf: appState.isLLMConnected,
          ),
          NavItem(
            id: NavTab.scanner,
            screen: const ScannerScreen(),
            item: const BottomNavigationBarItem(
              icon: Icon(Icons.scanner),
              label: 'Barcode',
            ),
          ),
          NavItem(
            id: NavTab.settings,
            screen: const SettingsScreen(),
            item: const BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ),
        ];

        final visibleItems = allItems.where((nav) => nav.showIf).toList();

        int calculatedIndex = visibleItems.indexWhere(
          (nav) => nav.id == _currentTab,
        );

        if (calculatedIndex == -1) {
          calculatedIndex = 0;
        }

        return Scaffold(
          body: IndexedStack(
            index: calculatedIndex,
            children: visibleItems.map((nav) => nav.screen).toList(),
          ),

          bottomNavigationBar: AppBottomNav(
            currentIndex: calculatedIndex,
            onTap: (index) =>
                setState(() => _currentTab = visibleItems[index].id),
            items: visibleItems.map((nav) => nav.item).toList(),
          ),
        );
      },
    );
  }
}
