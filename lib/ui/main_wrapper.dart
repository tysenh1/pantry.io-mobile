import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/data/repositories/app_state.dart';
import 'package:pantry_io_mobile/ui/screens/chatbot_screen.dart';
import 'package:pantry_io_mobile/ui/screens/debug_screen.dart';
import 'package:pantry_io_mobile/ui/screens/add_recipe_screen.dart';
import 'package:pantry_io_mobile/ui/screens/get_recipe_screen.dart';
import 'package:pantry_io_mobile/ui/screens/scanner_screen.dart';
import 'package:pantry_io_mobile/ui/screens/settings_screen.dart';
import 'package:pantry_io_mobile/ui/screens/widget_showcase_screen.dart';
import 'package:pantry_io_mobile/ui/widgets/bottom_nav.dart';
import 'package:pantry_io_mobile/domain/models/nav_item.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_button.dart';
import 'package:provider/provider.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  NavTab _currentTab = NavTab.addRecipe;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    switch(appState.phase) {
      case AppPhase.loading:
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator()
          )
        );

      case AppPhase.onboarding:
        return Scaffold(
          body: Center(
            // child: Text('me wen I on the board lololol')
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 40,
              children: [
                const Text('me wen I on the board lololol'),
                AppButton(
                  label: 'End Onboarding',
                  onPressed: () => appState.completeOnboarding()
                )
              ]
            )
          )
        );

      case AppPhase.app:
        return _MainNavigation(
          currentTab: _currentTab,
          isLLMConnected: appState.isLLMConnected,
          onTabChanged: (tab) {
            setState(() {
              _currentTab = tab;
            });
          }
        );
    }

    return Consumer<AppState>(
      builder: (context, appState, _) {
        return _MainNavigation(
          currentTab: _currentTab,
          isLLMConnected: appState.isLLMConnected,
          onTabChanged: (tab) {
            setState(() {
              _currentTab = tab;
            });
          },
        );
      },
    );
  }
}

class _MainNavigation extends StatelessWidget {
  const _MainNavigation({
    required this.currentTab,
    required this.isLLMConnected,
    required this.onTabChanged,
  });

  final NavTab currentTab;
  final bool isLLMConnected;
  final ValueChanged<NavTab> onTabChanged;

  @override
  Widget build(BuildContext context) {
    final allItems = _buildNavItems();

    final visibleItems = allItems
        .where((nav) => nav.showIf)
        .toList();

    var calculatedIndex = visibleItems.indexWhere(
          (nav) => nav.id == currentTab,
    );

    if (calculatedIndex == -1) {
      calculatedIndex = 0;
    }

    return Scaffold(
      body: IndexedStack(
        index: calculatedIndex,
        children: visibleItems
            .map((nav) => nav.screen)
            .toList(),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: calculatedIndex,
        onTap: (index) {
          onTabChanged(visibleItems[index].id);
        },
        items: visibleItems
            .map((nav) => nav.item)
            .toList(),
      ),
    );
  }

  List<NavItem> _buildNavItems() {
    return [
      NavItem(
        id: NavTab.debug,
        screen: const DatabaseDebugScreen(),
        item: const BottomNavigationBarItem(
          icon: Icon(Icons.bed),
          label: 'Debug',
        ),
      ),
      NavItem(
        id: NavTab.widgetShowcase,
        screen: const WidgetShowcaseScreen(),
        item: const BottomNavigationBarItem(
          icon: Icon(Icons.wallet),
          label: 'Widgets',
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
        showIf: isLLMConnected,
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
  }
}