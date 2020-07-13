import 'dart:convert';

import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/port.dart';
import 'package:olracddl/models/trip.dart';
import 'package:olracddl/providers/database.dart';
import 'package:olracddl/repos/port.dart';

class TripRepo extends DatabaseRepo<Trip> {
  TripRepo() : super(tableName: 'trips', database: DatabaseProvider().database);

  @override
  Future<Trip> find(int id) async {
    final List<Map<String, dynamic>> results = await database.query(tableName, where: 'id = $id');

    return results.isNotEmpty ? await fromDatabaseResult(results.first) : null;
  }

  @override
  Future<Trip> fromDatabaseResult(Map<String, dynamic> result) async {
    final Port port = await PortRepo().find(result['port_id']);

    return Trip(
      id: result['id'],
      uuid: result['uuid'],
      startedAt: DateTime.parse(result['started_at']),
      startLatitude: result['start_latitude'],
      startLongitude: result['start_longitude'],
      endedAt: DateTime.parse(result['ended_at']),
      endLatitude: result['end_latitude'],
      endLongitude: result['end_longitude'],
      skipperName: result['skipper_name'],
      crewMembers: jsonDecode(result['crew_members_json']) as List<String>,
      notes: result['notes'],
      port: port,
      uploadedAt: DateTime.parse(result['uploaded_at']),
      createdAt: DateTime.parse(result['created_at']),
    );
  }
}
