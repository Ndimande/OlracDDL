import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/vessel.dart';
import 'package:olracddl/providers/database.dart';

class VesselRepo extends DatabaseRepo<Vessel> {
  VesselRepo() : super(tableName: 'vessels', database: DatabaseProvider().database);

  @override
  Future<Vessel> fromDatabaseResult(Map<String, dynamic> result) async {
    return Vessel(
      id: result['id'],
      name: result['name'],
      vesselId: result['vessel_id'],
      createdAt: DateTime.parse(result['created_at']),
    );
  }
}
