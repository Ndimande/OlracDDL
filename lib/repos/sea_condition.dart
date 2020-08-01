import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/sea_condition.dart';
import 'package:olracddl/providers/database.dart';

class SeaConditionRepo extends DatabaseRepo<SeaCondition> {
  SeaConditionRepo() : super(tableName: 'sea_conditions', database: DatabaseProvider().database);

  @override
  Future<SeaCondition> fromDatabaseResult(Map<String, dynamic> result) async {
    return SeaCondition(
      id: result['id'],
      name: result['name'],
      namePortuguese: result['name_portuguese'],
      createdAt: DateTime.parse(result['created_at']),
      imageString: result['image_string'],
    );
  }
}
