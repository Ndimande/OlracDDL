import 'package:flutter/material.dart';
import 'package:migrator/migrator.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/app_migrations.dart';
import 'package:olracddl/providers/database.dart';
import 'package:olracddl/screens/splash_screen.dart';
import 'package:olracddl/screens/start_set_screen.dart';
import 'package:olracddl/screens/start_set_screen_two.dart';
import 'package:olracddl/theme.dart';
import 'package:sqflite/sqflite.dart';

import 'screens/login_screen.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';

final DatabaseProvider _databaseProvider = DatabaseProvider();
Database _database;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _database = await _databaseProvider.connect();
  final Migrator migrator = Migrator(_database, appMigrations);
  await migrator.run(AppConfig.RESET_DATABASE);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.APP_TITLE,
      theme: OlracThemesLight.olspsLightTheme,
      home: StartSetScreenTwo(), // Change to the screen you're working on
    );
  }
}
