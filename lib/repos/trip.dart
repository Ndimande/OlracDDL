import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/trip.dart';
import 'package:olracddl/providers/database.dart';

class TripRepo extends DatabaseRepo<Trip> {
  TripRepo() : super(tableName: 'trips', database: DatabaseProvider().database);

  @override
  Trip fromDatabaseResult(Map<String, dynamic> result) {
    return Trip(
      id: result['id'],
      uuid: result['uuid'],
      startDatetime: DateTime.parse(result['start_datetime']),
      startLatitude: result['start_latitude'],
      startLongitude: result['start_longitude'],
      endDatetime: DateTime.parse(result['end_datetime']),
      endLatitude: result['end_latitude'],
      endLongitude: result['end_longitude'],
      skipperName: result['skipper_name'],
      crewMembersJson: result['crew_members_json'],
      notes: result['notes'],
      portId: result['port_id'],
      uploadedAt: DateTime.parse(result['uploaded_at']),

      createdAt: DateTime.parse(result['created_at'],)


    );
  }
}
