import 'dart:convert';

import 'package:database_repo/database_repo.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/models/fishing_set.dart';
import 'package:olracddl/models/port.dart';
import 'package:olracddl/models/vessel.dart';

class Trip extends Model {
  String uuid;

  DateTime createdAt;

  DateTime startedAt;
  Location startLocation;

  DateTime endedAt;
  Location endLocation;


  String skipperName;
  List<String> crewMembers;
  String notes;

  DateTime uploadedAt;

  Port port;

  List<FishingSet> fishingSets;

  Vessel vessel;

  Trip({
    int id,
    this.uuid,
    this.createdAt,
    this.startedAt,
    this.startLocation,
    this.endedAt,
    this.endLocation,
    this.skipperName,
    this.crewMembers,
    this.notes,
    this.uploadedAt,
    this.port,
    this.fishingSets = const [],
    this.vessel,
  }) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'uuid': uuid,
      'started_at': startedAt.toIso8601String(),
      'start_latitude': startLocation.latitude,
      'start_longitude': startLocation.longitude,
      'ended_at': endedAt,
      'end_latitude': endLocation != null ? endLocation.latitude : null,
      'end_longitude': endLocation != null ? endLocation.longitude: null,
      'skipper_name': skipperName,
      'crew_members_json': jsonEncode(crewMembers),
      'notes': notes,
      'uploaded_at': uploadedAt == null ? null :uploadedAt.toIso8601String(),
      'port_id': port.id,
      'vessel_id': vessel.id,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'createdAt': createdAt,
      'startedAt': startedAt,
      'startLocation': startLocation.toMap(),
      'endedAt': endedAt,
      'endLocation': endLocation.toMap(),
      'skipperName': skipperName,
      'crewMembersJson': jsonEncode(crewMembers),
      'notes': notes,
      'uploadedAt': uploadedAt == null ? null : uploadedAt.toIso8601String(),
      'portID': port.id,
      'vesselID': vessel.id,
    };
  }
}
