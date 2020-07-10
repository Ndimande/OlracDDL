import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/fishing_area.dart';
import 'package:olracddl/providers/database.dart';

class FishingAreaRepo extends DatabaseRepo<FishingArea> {
  FishingAreaRepo() : super(tableName: 'fishing_areas', database: DatabaseProvider().database);

  @override
  FishingArea fromDatabaseResult(Map<String, dynamic> result) {
    return FishingArea(
      id: result['id'],
      name: result['name'],
      createdAt: DateTime.parse(result['created_at']),
    );
  }
}
