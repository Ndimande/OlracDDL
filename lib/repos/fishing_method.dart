import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/fishing_method.dart';
import 'package:olracddl/providers/database.dart';

class FishingMethodRepo extends DatabaseRepo<FishingMethod> {
  FishingMethodRepo() : super(tableName: 'fishing_methods', database: DatabaseProvider().database);

  @override
  FishingMethod fromDatabaseResult(Map<String, dynamic> result) {
    return FishingMethod(
      id: result['id'],
      name: result['name'],
      createdAt: DateTime.parse(result['created_at']),
    );
  }
}
