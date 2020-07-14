import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/catch_condition.dart';
import 'package:olracddl/providers/database.dart';

class CatchConditionRepo extends DatabaseRepo<CatchCondition> {
  CatchConditionRepo() : super(tableName: 'conditions', database: DatabaseProvider().database);

  @override
  Future<CatchCondition> fromDatabaseResult(Map<String, dynamic> result) async {
    return CatchCondition(
      id: result['id'],
      name: result['name'],
      createdAt: DateTime.parse(result['created_at']),
    );
  }
}
