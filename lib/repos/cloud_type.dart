import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/cloud_type.dart';
import 'package:olracddl/providers/database.dart';

class CloudTypeRepo extends DatabaseRepo<CloudType> {
  CloudTypeRepo() : super(tableName: 'cloud_types', database: DatabaseProvider().database);

  @override
  CloudType fromDatabaseResult(Map<String, dynamic> result) {
    return CloudType(
      id: result['id'],
      name: result['name'],
      createdAt: DateTime.parse(result['created_at']),
    );
  }
}
