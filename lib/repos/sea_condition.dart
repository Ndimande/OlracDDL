import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/sea_condition.dart';
import 'package:olracddl/providers/database.dart';

class SeaConditionRepo extends DatabaseRepo<SeaCondition> {
  SeaConditionRepo() : super(tableName: 'sea_conditions', database: DatabaseProvider().database);

  @override
  SeaCondition fromDatabaseResult(Map<String, dynamic> result) {
    return SeaCondition(
      id: result['id'],
      name: result['name'],
      createdAt: DateTime.parse(result['created_at']),
    );
  }
}
