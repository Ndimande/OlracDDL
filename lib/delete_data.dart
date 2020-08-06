
import 'package:dio/dio.dart';
import 'package:olracddl/models/trip.dart';
import 'package:olracddl/providers/dio.dart';

import 'app_config.dart';

const String _baseUrl = AppConfig.DDM_URL;
final Dio _dio = DioProvider().dio;

Future<void> deleteTrip( int id ) async {
  const String delete = _baseUrl + '/api/trips/';
  try {
    final Response response = await _dio.delete(delete+id.toString());
    print(response.data);
  } on DioError catch (e) {
    print(e.response.data);

  }
}
