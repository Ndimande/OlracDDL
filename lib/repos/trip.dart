import 'dart:convert';

import 'package:database_repo/database_repo.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/models/fishing_set.dart';
import 'package:olracddl/models/port.dart';
import 'package:olracddl/models/skipper.dart';
import 'package:olracddl/models/trip.dart';
import 'package:olracddl/models/vessel.dart';
import 'package:olracddl/providers/database.dart';
import 'package:olracddl/repos/fishing_set.dart';
import 'package:olracddl/repos/port.dart';
import 'package:olracddl/repos/skipper.dart';
import 'package:olracddl/repos/vessel.dart';

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

    final DateTime startedAt = DateTime.parse(result['started_at']);
    final Location startLocation = result['start_latitude'] == null
        ? null
        : Location(latitude: result['start_latitude'], longitude: result['start_longitude']);
    final Location endLocation = result['end_latitude'] == null
        ? null
        : Location(latitude: result['end_latitude'], longitude: result['end_longitude']);
    final Skipper skipper = await SkipperRepo().find(result['skipper_id']);
    final Vessel vessel = await VesselRepo().find(result['vessel_id']);

    final List<FishingSet> fishingSets = await FishingSetRepo().all(where: 'trip_id = ${result['id']}');

    return Trip(
      id: result['id'],
      uuid: result['uuid'],
      startedAt: startedAt,
      startLocation: startLocation,
      endedAt: result['ended_at'] == null ? null : DateTime.parse(result['ended_at']),
      endLocation: endLocation,
      skipper: skipper,
      crewMembers: (jsonDecode(result['crew_members_json']) as List<dynamic>).map((name) => name.toString()).toList(),
      notes: result['notes'],
      port: port,
      vessel: vessel,
      uploadedAt: result['uploaded_at'] == null ? null : DateTime.parse(result['uploaded_at']),
      createdAt: DateTime.parse(result['created_at']),
      fishingSets: fishingSets,
    );
  }
}
