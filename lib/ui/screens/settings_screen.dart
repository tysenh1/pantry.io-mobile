import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/logic/providers/app_state.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          Consumer<AppState>(
            builder: (context, appState, child) => SwitchListTile(
              title: const Text('Connect LLM'),
              subtitle: Text(
                appState.isLLMConnected
                    ? 'LLM is connected'
                    : 'LLM is not connected',
              ),
              value: appState.isLLMConnected,
              onChanged: (value) {
                appState.setLLMConnected(value);
              },
            ),
          ),
          ListTile(
            title: const Text('This is a placeholder'),
            trailing: const Text('Me wen I hold the place'),
          ),
        ],
      ),
    );
  }
}
