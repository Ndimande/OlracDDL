import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/species.dart';
import 'package:olracddl/providers/database.dart';

class SpeciesRepo extends DatabaseRepo<Species> {
  SpeciesRepo() : super(tableName: 'species', database: DatabaseProvider().database);

  @override
  Future<Species> fromDatabaseResult(Map<String, dynamic> result) async {
    return Species(
      id: result['id'],
      commonName: result['common_name'],
      scientificName: result['scientific_name'],
      createdAt: DateTime.parse(result['created_at']),
      commonNamePortuguese: result['common_name_portuguese'],
    );
  }
}
