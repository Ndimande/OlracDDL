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
}
