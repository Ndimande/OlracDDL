import 'package:olracddl/app_config.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  /// Singleton access
  factory DatabaseProvider() {
    return _databaseProvider;
  }

  /// SQLite db filename
  static const _filename = AppConfig.DATABASE_FILENAME;

  /// DatabaseProvider instance
  static final DatabaseProvider _databaseProvider = DatabaseProvider._();

  /// Database instance
  Database _database;

  /// Private constructor
  DatabaseProvider._();

  /// Get the database object
  Database get database {
    if (_database == null) {
      throw Exception('Database not connected');
    }
    return _database;
  }

  /// Open a connection to the database
  /// the database must be connected first or
  /// getting a db instance will fail.
  Future<Database> connect() async {
    _database = await openDatabase(_filename);
    return _database;
  }
}
