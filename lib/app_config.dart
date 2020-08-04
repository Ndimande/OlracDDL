/// This will be ignored in release mode
const bool _DEV_RESET_DB = false;

class AppConfig {
  /// Is the app running in debug mode?
  static final bool debugMode = (() {
    bool isDebug = false;
    assert((() => isDebug = true)());
    return isDebug;
  })();

  /// Drop and recreate the database if true
  /// DO NOT EDIT THIS.
  // ignore: avoid_bool_literals_in_conditional_expressions, non_constant_identifier_names
  static final bool RESET_DATABASE = debugMode ? _DEV_RESET_DB : true;

  /// The title of the app
  static const String APP_TITLE = 'OlracMDDL';

  /// The sqlite database filename
  static const String DATABASE_FILENAME = 'olracddl.db';

  /// The API key for this app for Sentry.io error reporting
  static const String SENTRY_DSN = 'https://TODO@sentry.io/3728395';

  static const String DDM_URL = 'https://azores.olracddm.com';
}
