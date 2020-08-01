import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/sea_bottom_type.dart';
import 'package:olracddl/providers/database.dart';

class SeaBottomTypeRepo extends DatabaseRepo<SeaBottomType> {
  SeaBottomTypeRepo() : super(tableName: 'sea_bottom_types', database: DatabaseProvider().database);

  @override
  Future<SeaBottomType> fromDatabaseResult(Map<String, dynamic> result) async {
    return SeaBottomType(
      id: result['id'],
      name: result['name'],
      namePortuguese: result['name_portuguese'],
      createdAt: DateTime.parse(result['created_at']),
    );
  }
}
