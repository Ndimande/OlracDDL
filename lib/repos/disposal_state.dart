import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/disposal_state.dart';
import 'package:olracddl/providers/database.dart';

class DisposalStateRepo extends DatabaseRepo<DisposalState> {
  DisposalStateRepo() : super(tableName: 'disposal_states', database: DatabaseProvider().database);

  @override
  Future<DisposalState> fromDatabaseResult(Map<String, dynamic> result) async {
    return DisposalState(
      id: result['id'],
      name: result['name'],
      createdAt: DateTime.parse(result['created_at']),
    );
  }
}
