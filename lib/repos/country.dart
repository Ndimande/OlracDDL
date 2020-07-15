import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/country.dart';
import 'package:olracddl/providers/database.dart';

class CountryRepo extends DatabaseRepo<Country> {
  CountryRepo() : super(tableName: 'countries', database: DatabaseProvider().database);

  @override
  Future<Country> fromDatabaseResult(Map<String, dynamic> result) async {
    return Country(
      id: result['id'],
      name: result['name'],
      createdAt: DateTime.parse(result['created_at']),
    );
  }
}
