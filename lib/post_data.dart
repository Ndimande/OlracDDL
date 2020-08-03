import 'dart:convert';
import 'dart:convert';
import 'dart:convert';
import 'dart:convert';
import 'dart:convert';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:intl/intl.dart';
import 'package:olracddl/models/cloud_cover.dart';
import 'package:olracddl/models/cloud_type.dart';
import 'package:olracddl/models/crew_member.dart';
import 'package:olracddl/models/current_fishing_method.dart';
import 'package:olracddl/models/fishing_area.dart';
import 'package:olracddl/models/fishing_method.dart';
import 'package:olracddl/models/fishing_set.dart';
import 'package:olracddl/models/moon_phase.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/models/profile.dart';
import 'package:olracddl/models/sea_bottom_type.dart';
import 'package:olracddl/models/sea_condition.dart';
import 'package:olracddl/models/species.dart';
import 'package:olracddl/providers/dio.dart';
import 'package:olracddl/repos/moon_phase.dart';

import 'app_data.dart';
import 'models/trip.dart';

const String _baseUrl = AppConfig.DDM_URL;
final Dio _dio = DioProvider().dio;

Future<Map<String, dynamic>> _formatTrip(Trip data) async {
  final FishingMethod fishingMethod = await CurrentFishingMethod.get();
  //print(data.startedAt);
  return {
    'start_datetime': DateFormat('yyyy-MM-dd HH:mm:ss').format(data.startedAt.toUtc()),
    'start_latitude': data.startLocation.latitude,
    'start_longitude': data.startLocation.longitude,
    'end_datetime': DateFormat('yyyy-MM-dd HH:mm:ss').format(data.endedAt.toUtc()),
    'end_latitude': data.endLocation.latitude,
    'end_longitude': data.endLocation.longitude,
    'vessel_id': data.vessel.id,
    'gear_id': fishingMethod.id,
    'user_id': 1

  };
}

Future<Map<String, dynamic>> _formatFishingSet(FishingSet data) async {
  final FishingMethod fishingMethod = await CurrentFishingMethod.get();
  final FishingArea fishingArea = await FishingArea();
  //varr = data.seaBottomDepthUnit.toString() ;
//print(varr);
  //final FishingSet targetSpecies = await FishingSet(startLocation: null);
  return {
    'start_datetime': DateFormat('yyyy-MM-dd HH:mm:ss').format(data.startedAt.toUtc()),
    'start_latitude': data.startLocation.latitude,
    'start_longitude': data.startLocation.longitude,

    'target_species_id': data.targetSpecies.id,
    //'fishing_depth' : data.seaBottomDepthUnit,
    'sea_bottom_depth' : data.seaBottomDepth,
    'sea_bottom_type_id' : data.seaBottomType.id ,
    'stat_rectangle_id' : fishingArea.id,
    'min_hook_size' :data.minimumHookSize,
    'max_number_hooks' : data.hooks,
    'max_number_lines': data.linesUsed,
    'sea_condition_id' : data.seaCondition.id,
    'cloud_cover_id' : data.cloudCover.id,
    'cloud_type_id' : data.cloudType.id,
    'moon_phase_id': data.moonPhase.id,
    'gear_id' : fishingMethod.id,

    'end_datetime': DateFormat('yyyy-MM-dd HH:mm:ss').format(data.endedAt.toUtc()),
    'end_latitude': data.endLocation.latitude,
    'end_longitude': data.endLocation.longitude,
    'trip_id': 1,

//
//    'startedAt': startedAt == null ? null : startedAt.toUtc().toIso8601String(),
//    'endedAt': endedAt == null ? null : endedAt.toUtc().toIso8601String(),
//    'startLatitude': startLocation.latitude,
//    'startLongitude': startLocation.longitude,
//    'endLatitude': endLocation.latitude,
//    'endLongitude': endLocation.longitude,
//    'seaBottomDepth': seaBottomDepth,
//    'seaBottomDepthUnit': seaBottomDepthUnit,
//    'minimumHookSize': minimumHookSize,
//    'hooks': hooks,
//    'traps': traps,
//    'lines_used': linesUsed,
//    'notes': notes,
//    'tripID': tripID,
//    'targetSpeciesID': targetSpecies.id,
//    'moonPhaseID': moonPhase.id,
//    'cloudTypeID': cloudType.id,
//    'cloudCoverID': cloudCover.id,
//    'seaConditionID': seaCondition.id,
//    'fishingMethodID': fishingMethod.id,

  };
}
Future<Map<String, dynamic>> postTrip(Trip data ) async {
  final Map<String, dynamic> formatted = await _formatTrip(data);
  final String json = jsonEncode(formatted);
  Map<String,dynamic> printer;
  const String postTo = _baseUrl + '/api/trips';
  try {
    final Response response = await _dio.post(postTo, data: json);
    printer = response.data;
    print(response.data);
  } on DioError catch (e) {
    print(e.response.data);
      printer = null;
      print(printer);
  }return printer;
}

Future<Map<String, dynamic>> postFishingSet(FishingSet data ) async {
  final Map<String, dynamic> formatted = await _formatFishingSet(data);
  final String json = jsonEncode(formatted);
  Map<String,dynamic> printer;
  const String postTo = _baseUrl + '/api/hauls';
  try {
    final Response response = await _dio.post(postTo, data: json);
    printer = response.data;
    print(response.data);
  } on DioError catch (e) {
    print(e.response.data);
     printer = null;
     print(printer);
  }return printer;
}




Future<void> postCrewMembers(CrewMember data) async {
  const String post = _baseUrl + '/api/trips/';
  final String json = jsonEncode(data.toMap());
  final Response response = await _dio.post(post, data: json);
}
