import 'package:flutter/material.dart';
import 'package:migrator/migrator.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/app_migrations.dart';
import 'package:olracddl/models/profile.dart';
import 'package:olracddl/providers/database.dart';
import 'package:olracddl/screens/home/home.dart';
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

/// Run things once the app has started and the splash screen is showing.
Future<Profile> _onAppRunning() async {
  // Restore persisted profile into app state
  final Profile profile = await Profile.get();
  return profile;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    _onAppRunning().then((Profile profile) async {
      // Delay to show logos
      if (!AppConfig.debugMode) await Future.delayed(const Duration(seconds: 5));

      if (profile != null) {
        await _navigatorKey.currentState.pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        await _navigatorKey.currentState.pushReplacement(MaterialPageRoute(builder: (_) => SignUpScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: AppConfig.APP_TITLE,
      theme: OlracThemesLight.olspsLightTheme,
      home: SplashScreen(), // Change to the screen you're working on
    );
  }
}
