import 'package:flutter/material.dart';
import 'package:migrator/migrator.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/app_migrations.dart';
import 'package:olracddl/providers/database.dart';
import 'package:olracddl/screens/sign_up/sign_up.dart';
import 'package:olracddl/screens/splash_screen.dart';
import 'package:olracddl/theme.dart';
import 'package:sqflite/sqflite.dart';

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
      home: SignUpScreen(), // Change to the screen you're working on
    );
  }
}
