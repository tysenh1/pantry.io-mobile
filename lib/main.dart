import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/services/database_service.dart';
import 'core/providers/app_state.dart';
import 'shared/screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DatabaseService()),
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pantry App',
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      home: const MainScreen(),
    );
  }
}

