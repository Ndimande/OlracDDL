import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/condition.dart';
import 'package:olracddl/providers/database.dart';

class ConditionRepo extends DatabaseRepo<Condition> {
  ConditionRepo() : super(tableName: 'conditions', database: DatabaseProvider().database);

  @override
  Condition fromDatabaseResult(Map<String, dynamic> result) {
    return Condition(
      id: result['id'],
      name: result['name'],
      createdAt: DateTime.parse(result['created_at']),
    );
  }
}
