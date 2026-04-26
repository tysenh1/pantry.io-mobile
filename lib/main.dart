import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/services/database_service.dart';
import 'logic/providers/app_state.dart';
import 'ui/main_wrapper.dart';

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
      home: const MainWrapper(),
    );
  }
}
