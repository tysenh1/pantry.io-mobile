import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/core/providers/app_state.dart';
import 'package:provider/provider.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: onTap,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add Recipe',
            ),

            const BottomNavigationBarItem(
              icon: Icon(Icons.cookie),
              label: 'Quick Add',
            ),
            if (appState.isLLMConnected)
              const BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chatbot',
              ),

            const BottomNavigationBarItem(
              icon: Icon(Icons.scanner),
              label: 'Barcode Scanner',
            ),

            const BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        );
      },
    );
  }
}
