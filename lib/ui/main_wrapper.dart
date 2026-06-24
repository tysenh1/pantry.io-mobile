import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/data/repositories/app_state.dart';
import 'package:pantry_io_mobile/ui/screens/chatbot_screen.dart';
import 'package:pantry_io_mobile/ui/screens/debug_screen.dart';
import 'package:pantry_io_mobile/ui/screens/add_recipe_screen.dart';
import 'package:pantry_io_mobile/ui/screens/get_recipe_screen.dart';
import 'package:pantry_io_mobile/ui/screens/scanner_screen.dart';
import 'package:pantry_io_mobile/ui/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:pantry_io_mobile/ui/widgets/bottom_nav.dart';
import 'package:pantry_io_mobile/domain/models/nav_item.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  NavTab _currentTab = NavTab.addRecipe;

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppState, AppDatabase>(
      builder: (context, appState, databaseService, _) {
        final allItems = [
          NavItem(
            id: NavTab.debug,
            screen: const DatabaseDebugScreen(),
            item: const BottomNavigationBarItem(
              icon: Icon(Icons.bed),
              label: 'Debug',
            ),
          ),
          NavItem(
            id: NavTab.addRecipe,
            screen: const AddRecipeScreen(),
            item: const BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add Recipe',
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
            id: NavTab.receipGetter,
            screen: const GetRecipeScreen(),
            item: const BottomNavigationBarItem(
              icon: Icon(Icons.get_app),
              label: 'Recipes',
            ),
          ),
          NavItem(
            id: NavTab.scanner,
            screen: ScannerScreen(isActiveTab: _currentTab == NavTab.scanner),
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
