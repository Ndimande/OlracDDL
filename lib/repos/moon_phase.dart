import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/moon_phase.dart';
import 'package:olracddl/providers/database.dart';

class MoonPhaseRepo extends DatabaseRepo<MoonPhase> {
  MoonPhaseRepo() : super(tableName: 'moon_phases', database: DatabaseProvider().database);

  @override
  Future<MoonPhase> fromDatabaseResult(Map<String, dynamic> result) async {
    return MoonPhase(
      id: result['id'],
      name: result['name'],
      createdAt: DateTime.parse(result['created_at']),
    );
  }
}
