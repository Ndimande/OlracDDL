import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/skipper.dart';
import 'package:olracddl/providers/database.dart';

class SkipperRepo extends DatabaseRepo<Skipper> {
  SkipperRepo() : super(tableName: 'skippers', database: DatabaseProvider().database);

  @override
  Future<Skipper> fromDatabaseResult(Map<String, dynamic> result) async {
    return Skipper(
      id: result['id'],
      name: result['name'],
      shortName: result['short_name'],
      seamanId: result['seaman_id'],
      createdAt: DateTime.parse(result['created_at']),
    );
  }
}
