import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/crew_member.dart';
import 'package:olracddl/providers/database.dart';

class CrewMemberRepo extends DatabaseRepo<CrewMember> {
  CrewMemberRepo() : super(tableName: 'crew_members', database: DatabaseProvider().database);

  @override
  Future<CrewMember> fromDatabaseResult(Map<String, dynamic> result) async {
    return CrewMember(
      id: result['id'],
      name: result['name'],
      shortName: result['short_name'],
      islandID: result['island_id'],
      seamanId: result['seaman_id'],
      createdAt: DateTime.parse(result['created_at']),
    );
  }
}
