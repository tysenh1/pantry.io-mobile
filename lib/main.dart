import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:pantry_io_mobile/core/storage/storage_service.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/services/get_recipe_service.dart';
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
        // Uncomment this code if you add more db stuff to the service and want to add it as a provider again
        // ProxyProvider<AppDatabase, GetRecipeService>(
        //   update: (_, db, __) => GetRecipeService(db),
        // ),
        Provider<StorageService>(
          create: (context) => StorageService()
        ),

        ChangeNotifierProvider<AppState>(
          create: (context) {
            final db = Provider.of<AppDatabase>(context, listen: false);
            final storage = context.read<StorageService>();
            return AppState(
              db: db,
              storage: storage
            )..initialize();
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
