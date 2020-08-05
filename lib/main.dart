import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:migrator/migrator.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/app_data.dart';
import 'package:olracddl/app_migrations.dart';
import 'package:olracddl/localization/app_localization.dart';
import 'package:olracddl/models/catch_condition.dart';
import 'package:olracddl/models/profile.dart';
import 'package:olracddl/providers/database.dart';
import 'package:olracddl/providers/dio.dart';
import 'package:olracddl/screens/home.dart';
import 'package:olracddl/screens/sign_up.dart';
import 'package:olracddl/screens/splash.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/dialogs/download_dialogbox.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'delete_lookup_data.dart';
import 'get_lookup_data.dart';

final DatabaseProvider _databaseProvider = DatabaseProvider();
Database _database;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _database = await _databaseProvider.connect();
  final Migrator migrator = Migrator(_database, appMigrations);
  await migrator.run(AppConfig.RESET_DATABASE);

  // await deleteSpecies(); 
  // await deleteSkippers(); 
  // await deleteCrewMembers();
  // await deleteVessels();
  // //await deleteSeaConditions(); 
  // await deleteSeaBottomType(); 
  // await deleteCatchConditions();
  // await deleteFishingAreas();
  // await deletePorts(); 

  DioProvider().init();

  

  await storeSpecies();
  await storeSeaBottomTypes();
  //await storeSeaConditions();
  //await storeMoonPhases();
  //await  storeCloudTypes();
  //await storeCloudCovers();
  await storePorts();
  await storeVesselNames();
  await storeFishingAreas();
  await storeCrewMembers();
  await storeSkippers();
  await storeCatchConditions();
  //await storeFishingMethods(); //works but still need to figure out how to deal with pictures!!

  runApp(MyApp());
}

/// Run things once the app has started and the splash screen is showing.
Future<void> _onAppRunning() async {
  AppData.profile = await Profile.get();
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findRootAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    _onAppRunning().then((_) async {
      // Delay to show logos
//      if (!AppConfig.debugMode)
      await Future.delayed(const Duration(seconds: 5));

      if (AppData.profile != null) {
        await _navigatorKey.currentState.pushReplacement(MaterialPageRoute(
            maintainState: true, builder: (_) => HomeScreen()));
      } else {
        await _navigatorKey.currentState.pushReplacement(MaterialPageRoute(
            maintainState: false, builder: (_) => SignUpScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('pt', 'PT'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale.languageCode &&
              locale.countryCode == deviceLocale.countryCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (_) {
            return SplashScreen();
          },
        );
      },
      navigatorKey: _navigatorKey,
      title: AppConfig.APP_TITLE,
      theme: OlracThemesLight.olspsLightTheme,
      home: SplashScreen(), // Change to the screen you're working on
    );
  }
}
