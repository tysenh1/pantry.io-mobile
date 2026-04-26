import 'package:flutter/material.dart';
import '../database/app_database.dart';

class DatabaseService extends ChangeNotifier {
  late final AppDatabase db;

  DatabaseService() : db = AppDatabase();

  @override
  void dispose() {
    db.close();
    super.dispose();
  }
}

