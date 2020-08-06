import 'package:dio/dio.dart';
import 'package:olracddl/models/island.dart';
import 'package:olracddl/models/port.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/providers/dio.dart';

const String _baseUrl = AppConfig.DDM_URL + '/api/islands';
final Dio _dio = DioProvider().dio;
Future<List<Island>> getIslands() async {
  Response response;
  response = await _dio.get(_baseUrl);

  final List islandsList = response.data['data'];
  final List<Island> islandsType = [];

  for (final Map islandData in islandsList) {
    islandsType.add(Island(
      name: islandData['displayname'],
      portugueseName: islandData['displayname_portuguese'],
    ));
  }
  return islandsType;
}