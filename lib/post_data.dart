import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:intl/intl.dart';
import 'package:olracddl/models/crew_member.dart';
import 'package:olracddl/models/current_fishing_method.dart';
import 'package:olracddl/models/fishing_method.dart';
import 'package:olracddl/models/moon_phase.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/models/profile.dart';
import 'package:olracddl/providers/dio.dart';
import 'package:olracddl/repos/moon_phase.dart';

import 'app_data.dart';
import 'models/trip.dart';

const String _baseUrl = AppConfig.DDM_URL;
final Dio _dio = DioProvider().dio;

Future<Map<String, dynamic>> _formatTrip(Trip data) async {
  final FishingMethod fishingMethod = await CurrentFishingMethod.get();
  print(data.startedAt);
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

Future<void> postTrip(Trip data) async {
  final Map<String, dynamic> formatted = await _formatTrip(data);
  final String json = jsonEncode(formatted);
  const String post = _baseUrl + '/api/trips';
  try {
    final Response response = await _dio.post(post, data: json);
    print(response.data.toString());
  } on DioError catch (e) {
    print(e.response.data);
  }
}

Future<void> postCrewMembers(CrewMember data) async {
  const String post = _baseUrl + '/api/trips/';
  final String json = jsonEncode(data.toMap());
  final Response response = await _dio.post(post, data: json);
}
