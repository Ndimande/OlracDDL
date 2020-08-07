import 'dart:convert';

import 'package:database_repo/database_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/models/crew_member.dart';
import 'package:olracddl/models/fishing_set.dart';
import 'package:olracddl/models/port.dart';
import 'package:olracddl/models/skipper.dart';
import 'package:olracddl/models/vessel.dart';

import 'current_fishing_method.dart';
import 'fishing_method.dart';
import 'island.dart';

class Trip extends Model {
  String uuid;

  DateTime createdAt;

  DateTime startedAt;
  Location startLocation;

  DateTime endedAt;
  Location endLocation;

  Skipper skipper;
  List<CrewMember> crewMembers;
  String notes;

  DateTime uploadedAt;

  Island island;
  Island returnIsland; 

  Port port;
  Port returnPort; 

  List<FishingSet> fishingSets;

  Vessel vessel;

  bool get isActive => endedAt == null;

  bool get isUploaded => uploadedAt != null;

  Trip({
    int id,
    @required this.uuid,
    this.createdAt,
    @required this.startedAt,
    @required this.startLocation,
    this.endedAt,
    this.endLocation,
    @required this.skipper,
    @required this.crewMembers,
    this.notes,
    this.uploadedAt,
    @required this.port,
    @required this.island,
    this.returnPort,
    this.returnIsland, 
    this.fishingSets = const [],
    @required this.vessel,
  })  : assert(uuid != null),
        assert(startedAt != null),
        assert(startLocation != null),
        assert(skipper != null),
        assert(crewMembers != null),
        assert(port != null),
        assert(island != null),
        assert(vessel != null),
        assert(startLocation != null),
        assert(startLocation != null),
        super(id: id);


  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'uuid': uuid,
      'started_at': startedAt.toIso8601String(),
      'start_latitude': startLocation.latitude,
      'start_longitude': startLocation.longitude,
      'ended_at': endedAt == null ? null : endedAt.toIso8601String(),
      'end_latitude': endLocation != null ? endLocation.latitude : null,
      'end_longitude': endLocation != null ? endLocation.longitude : null,
      'skipper_id': skipper.id,
      'notes': notes,
      'uploaded_at': uploadedAt == null ? null : uploadedAt.toIso8601String(),
      'island_id': island.id, 
      'port_id': port.id,
     // 'return_island_id': (returnIsland.id == null)? null : returnIsland.id,
     // 'return_port_id': (returnPort.id == null)? null : returnPort.id,
      'vessel_id': vessel.id,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'createdAt': createdAt.toIso8601String(),
      'startedAt': startedAt.toIso8601String(),
      'startLocation': startLocation.toMap(),
      'endedAt': endedAt == null ? null : endedAt.toIso8601String(),
      'endLocation': endLocation.toMap(),
      'skipper': skipper.toMap(),
      'notes': notes,
      'uploadedAt': uploadedAt == null ? null : uploadedAt.toIso8601String(),
      'islandID': island.id,
      'portID': port.id,
      'returnIslandID': (returnIsland.id == null)? null : returnIsland.id,
      'returnPortID': (returnPort.id == null)? null : returnPort.id,
      'vesselID': vessel.id,
    };
  }



}
