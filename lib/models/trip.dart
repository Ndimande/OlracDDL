import 'dart:convert';

import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/fishing_set.dart';
import 'package:olracddl/models/port.dart';

class Trip extends Model {
  String uuid;

  DateTime createdAt;

  DateTime startedAt;
  String startLatitude;
  String startLongitude;

  DateTime endedAt;
  String endLatitude;
  String endLongitude;

  String skipperName;
  List<String> crewMembers;
  String notes;

  DateTime uploadedAt;

  Port port;

  List<FishingSet> fishingSets;

  Trip({
    int id,
    this.uuid,
    this.createdAt,
    this.startedAt,
    this.startLatitude,
    this.startLongitude,
    this.endedAt,
    this.endLatitude,
    this.endLongitude,
    this.skipperName,
    this.crewMembers,
    this.notes,
    this.uploadedAt,
    this.port,
    this.fishingSets,
  }) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'uuid': uuid,
      'created_at': createdAt,
      'started_at': startedAt,
      'start_latitude': startLatitude,
      'start_longitude': startLongitude,
      'ended_at': endedAt,
      'end_latitude': endLatitude,
      'end_longitude': endLongitude,
      'skipper_name': skipperName,
      'crew_members_json': jsonEncode(crewMembers),
      'notes': notes,
      'uploaded_at': uploadedAt.toIso8601String(),
      'port_id': port.id,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'createdAt': createdAt,
      'startedAt': startedAt,
      'startLatitude': startLatitude,
      'startLongitude': startLongitude,
      'endedAt': endedAt,
      'endLatitude': endLatitude,
      'endLongitude': endLongitude,
      'skipperName': skipperName,
      'crewMembersJson': jsonEncode(crewMembers),
      'notes': notes,
      'uploadedAt': uploadedAt.toIso8601String(),
      'portID': port.id,
    };
  }
}
