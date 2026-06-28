import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:provider/provider.dart';
import 'package:pantry_io_mobile/data/repositories/app_state.dart';
import 'ui/main_wrapper.dart';
import 'core/utils/theme.dart';
import 'core/utils/theme-utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  OpenFoodAPIConfiguration.userAgent = UserAgent(
    name: 'PantryIOMobile',
    version: '1.0.0',
    system: 'Flutter'
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<AppDatabase>(
          create: (context) => AppDatabase.instance,
          dispose: (context, db) => db.close(),
        ),

        ChangeNotifierProvider<AppState>(
          create: (context) {
            final db = Provider.of<AppDatabase>(context, listen: false);
            return AppState(db: db);
          }
        )
      ],
      child: const MyApp(),

    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Inter", "Nunito");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'Pantry App',
      theme: theme.light(),
      // darkTheme: theme.dark(),
      themeMode: ThemeMode.system,
      home: const MainWrapper(),
    );
  }
}
