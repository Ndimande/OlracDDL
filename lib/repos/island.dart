import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/island.dart';
import 'package:olracddl/providers/database.dart';

class IslandRepo extends DatabaseRepo<Island> {
  IslandRepo() : super(tableName: 'islands', database: DatabaseProvider().database);

  @override
  Future<Island> fromDatabaseResult(Map<String, dynamic> result) async {
    return Island(
      id: result['id'],
      name: result['name'],
    //  islandID: result['island_id'],
      portugueseName: result['portuguese_name'],
      createdAt: DateTime.parse(result['created_at']),
    );
  }
}
