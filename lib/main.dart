import 'package:flutter/material.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:provider/provider.dart';
import 'package:pantry_io_mobile/data/repositories/app_state.dart';
import 'ui/main_wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final db = AppDatabase();

  runApp(
    MultiProvider(
      providers: [
        Provider<AppDatabase>.value(value: db),
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
