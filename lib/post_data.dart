import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:olracddl/models/moon_phase.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/providers/dio.dart';
import 'package:olracddl/repos/moon_phase.dart';

import 'app_data.dart';
import 'models/trip.dart';

const String _baseUrl = AppConfig.DDM_URL;
final Dio _dio = DioProvider().dio;

Future<void>  postTrip(Trip data) async {
  final String json = jsonEncode(data.toMap());
  const String post = _baseUrl + '/api/trips';
  final Response response = await _dio.post(
//        post, data: {
//        'start_datetime': '2020-07-01 01:00:00',
//        'start_latitude' : 20,
//        'start_longitude' : 30,
//        'vessel_id' : 1,
//        'gear_id' : 1,
//        'user_id': 1,
//        'end_datetime': '2020-07-10 01:00:00',
//        'end_latitude' :25,
//        'end_longitude':35,
//      }
         post, data: json
  );
  //print(response.data.toString());
}
Future<void>  postCrewMembers() async {
  const String post = _baseUrl + '/api/trips/';
  final Response response = await _dio.post(
      post, data: {
      'trip_id' : 1,
      'crew_id': 1,
  }
  );
}

Future<void>  postHauls() async {
  const String post = _baseUrl + '/api/hauls';
  final Response response = await _dio.post(
      post, data: {
    'start_datetime': 'rerum',
    'start_latitude': 12.9,
    'start_longitude': 9412.39,
    'target_species_id': 3,
    'fishing_depth': 6,
    'sea_bottom_depth': 9,
    'sea_bottom_type_id': 11,
    'stat_rectangle_id': 5,
    'min_hook_size': 16,
    'max_number_hooks': 1,
    'max_number_lines': 6,
    'sea_condition_id': 19,
    'cloud_cover_id': 1,
    'cloud_type_id': 16,
    'moon_phase_id': 18,
    'gear_id': 16,
    'end_datetime': 'libero',
    'end_latitude': 120331.53418,
    'end_longitude': 34902470.38,
    'trip_id': 12
  }
  );
}






