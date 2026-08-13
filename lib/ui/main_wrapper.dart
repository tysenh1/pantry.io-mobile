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
  NavTab _currentTab = NavTab.scanner;
  bool _walkthroughStarted = false;

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
        if (!_walkthroughStarted) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  const Text('Welcome to Pantry.io!'),
                  AppButton(
                    label: 'Start Walkthrough',
                    type: AppButtonType.primary,
                    onPressed: () => setState(() => _walkthroughStarted = true),
                  ),
                  AppButton(
                    label: 'Skip Onboarding',
                    type: AppButtonType.secondary,
                    onPressed: () => appState.completeOnboarding(),
                  ),
                ],
              ),
            ),
          );
        }
        // Fall through to render tutorial navigation once walkthrough starts
        return MainNavigation(
          currentTab: _currentTab,
          isLLMConnected: appState.isLLMConnected,
          isTutorial: true,
          onTabChanged: (tab) => setState(() => _currentTab = tab),
        );

      case AppPhase.app:
        return MainNavigation(
          currentTab: _currentTab,
          isLLMConnected: appState.isLLMConnected,
          isTutorial: false,
          onTabChanged: (tab) {
            setState(() {
              _currentTab = tab;
            });
          }
        );
    }
  }
}

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key,
    required this.currentTab,
    required this.isLLMConnected,
    required this.onTabChanged,
    required this.isTutorial,
    this.onTutorialNextTab,
  });

  final NavTab currentTab;
  final bool isLLMConnected;
  final ValueChanged<NavTab> onTabChanged;
  final bool isTutorial;
  final VoidCallback? onTutorialNextTab;

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
      body: isTutorial
          ? _buildCurrentScreen(context)
          : IndexedStack(
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

  Widget _buildCurrentScreen(BuildContext context) {
    switch (currentTab) {
      case NavTab.debug:
        return const DatabaseDebugScreen();
      case NavTab.widgetShowcase:
        return const WidgetShowcaseScreen();
      case NavTab.addRecipe:
        return AddRecipeScreen(
          isTutorial: isTutorial,
          onTutorialNext: isTutorial ? () => context.read<AppState>().completeOnboarding() : null
        );
      case NavTab.chatbot:
        return const ChatbotScreen();
      case NavTab.receipGetter:
        return GetRecipeScreen(
          isTutorial: isTutorial,
          onTutorialNext: isTutorial ? () => onTabChanged(NavTab.addRecipe) : null,
        );
      case NavTab.scanner:
        return ScannerScreen(
          isTutorial: isTutorial,
          onTutorialNext: isTutorial ? () => onTabChanged(NavTab.receipGetter) : null,
        );
      case NavTab.settings:
        return const SettingsScreen();
    }
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
        screen: AddRecipeScreen(
          isTutorial: isTutorial,
          onTutorialNext: () => onTabChanged(NavTab.receipGetter)
        ),
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
        screen: GetRecipeScreen(
          isTutorial: isTutorial,
          onTutorialNext: () => onTabChanged(NavTab.scanner),
        ),
        item: const BottomNavigationBarItem(
          icon: Icon(Icons.get_app),
          label: 'Recipes',
        ),
      ),
      NavItem(
        id: NavTab.scanner,
        screen: const ScannerScreen(isTutorial: false, onTutorialNext: null),
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