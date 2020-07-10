//changed

const bool DEV_RESET_DB = true;

class AppConfig {
  /// Is the app running in debug mode?
  static final bool debugMode = (() {
    bool isDebug = false;
    assert((() => isDebug = true)());
    return isDebug;
  })();

  /// Drop and recreate the database if true
  // ignore: avoid_bool_literals_in_conditional_expressions, non_constant_identifier_names
  static final bool RESET_DATABASE = debugMode ? DEV_RESET_DB : true;

  /// The title of the app
  static const String APP_TITLE = 'SharkTrace';
  static const String APP_SUBTITLE = 'Factory';

  /// The sqlite database filename
  static const String DATABASE_FILENAME = 'sharktrace_factory.db';

    //Make sure with Werner that this is okay 
    //*************************************** 
    /// The API key for this app for Sentry.io error reporting
  static const String SENTRY_DSN = 'https://46c3ef2535a2460a8a00c013f0738e17@sentry.io/3728395';  
}
