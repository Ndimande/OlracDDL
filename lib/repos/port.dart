import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/port.dart';
import 'package:olracddl/providers/database.dart';

class PortRepo extends DatabaseRepo<Port> {
  PortRepo() : super(tableName: 'ports', database: DatabaseProvider().database);

  @override
  Future<Port> fromDatabaseResult(Map<String, dynamic> result) async {
    return Port(
      id: result['id'],
      name: result['name'],
      portugueseName: result['portuguese_name'],
      createdAt: DateTime.parse(result['created_at']),
      island: result['island_id'],
    );
  }
}
