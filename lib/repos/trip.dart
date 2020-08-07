import 'package:database_repo/database_repo.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/models/crew_member.dart';
import 'package:olracddl/models/fishing_set.dart';
import 'package:olracddl/models/island.dart';
import 'package:olracddl/models/port.dart';
import 'package:olracddl/models/skipper.dart';
import 'package:olracddl/models/trip.dart';
import 'package:olracddl/models/vessel.dart';
import 'package:olracddl/providers/database.dart';
import 'package:olracddl/repos/crew_member.dart';
import 'package:olracddl/repos/fishing_set.dart';
import 'package:olracddl/repos/island.dart';
import 'package:olracddl/repos/port.dart';
import 'package:olracddl/repos/skipper.dart';
import 'package:olracddl/repos/vessel.dart';
import 'package:sqflite/sqflite.dart';

const _TRIP_HAS_CREW_MEMBERS = 'trip_has_crew_members';

class TripRepo extends DatabaseRepo<Trip> {
  TripRepo() : super(tableName: 'trips', database: DatabaseProvider().database);

  @override
  Future<Trip> find(int id) async {
    final List<Map<String, dynamic>> results = await database.query(tableName, where: 'id = $id');

    return results.isNotEmpty ? await fromDatabaseResult(results.first) : null;
  }

  @override
  Future<int> store(Trip trip) async {
    // if no id create a new record
    if (trip.id == null) {
      final int id = await database.insert(tableName, await trip.toDatabaseMap());
      trip.id = id;
      await _storeCrewMembers(trip);
      return id;
    }
    // We remove the id completely or sqlite will try to set id = null
    final Map<String, dynamic> dbMap = await trip.toDatabaseMap();
    dbMap.remove('id');
    await _removeCrewMembers(trip);
    await _storeCrewMembers(trip);
    return await database.update(tableName, dbMap, where: 'id = ${trip.id}');
  }

  Future<void> _storeCrewMembers(Trip trip) async {
    for (final CrewMember crewMember in trip.crewMembers) {
      await database.insert(_TRIP_HAS_CREW_MEMBERS, {'trip_id': trip.id, 'crew_member_id': crewMember.id});
    }
  }

  Future<void> _removeCrewMembers(Trip trip) async {
    await database.delete(_TRIP_HAS_CREW_MEMBERS, where: 'trip_id = ${trip.id}');
  }

  @override
  Future<Trip> fromDatabaseResult(Map<String, dynamic> result) async {
    final Island island = await IslandRepo().find(result['island_id']);
    final Port port = await PortRepo().find(result['port_id']);

    final Island returnIsland = await IslandRepo().find(result['return_island_id']);
    final Port returnPort = await PortRepo().find(result['return_port_id']); 

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
    final Database db = DatabaseProvider().database;

    final List<Map> results = await db.query('trip_has_crew_members', where: 'trip_id = ${result['id']}');
    final List<CrewMember> crewMembers = [];
    for (final Map result in results) {
      final CrewMember crewMember = await CrewMemberRepo().find(result['crew_member_id']);
      crewMembers.add(crewMember);
    }

    return Trip(
      id: result['id'],
      uuid: result['uuid'],
      startedAt: startedAt,
      startLocation: startLocation,
      endedAt: result['ended_at'] == null ? null : DateTime.parse(result['ended_at']),
      endLocation: endLocation,
      skipper: skipper,
      crewMembers: crewMembers,
      notes: result['notes'],
      island: island,
      port: port,
      returnIsland: returnIsland,
      returnPort: returnPort,
      vessel: vessel,
      uploadedAt: result['uploaded_at'] == null ? null : DateTime.parse(result['uploaded_at']),
      createdAt: DateTime.parse(result['created_at']),
      fishingSets: fishingSets,
    );
  }
}
