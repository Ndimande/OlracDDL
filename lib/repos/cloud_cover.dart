import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/cloud_cover.dart';
import 'package:olracddl/providers/database.dart';

class CloudCoverRepo extends DatabaseRepo<CloudCover> {
  CloudCoverRepo() : super(tableName: 'cloud_covers', database: DatabaseProvider().database);

  @override
  Future<CloudCover> fromDatabaseResult(Map<String, dynamic> result) async {
    return CloudCover(
      id: result['id'],
      name: result['name'],
      createdAt: DateTime.parse(result['created_at']),
      imageString: result['image_string'],
      portugueseName: result['portuguese_name'],
    );
  }
}
