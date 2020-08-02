
import 'package:dio/dio.dart';
import 'package:olracddl/models/fishing_area.dart';
import 'package:olracddl/models/vessel.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/providers/dio.dart';
import 'package:olracddl/repos/vessel.dart';

import '../get_lookup_data.dart';

const String _baseUrl = AppConfig.DDM_URL + '/api/stat_rectangles';
final Dio _dio = DioProvider().dio;

Future<List<FishingArea>> getFishingAreas() async {
  Response response;
  response = await _dio.get(_baseUrl);

  final List fishingAreaList = response.data['data'];
  final List<FishingArea> fishingAreas = [];
  for(final Map fishingArea in fishingAreaList){
    fishingAreas.add(FishingArea(name: fishingArea['displayname']));
  }

  return fishingAreas;
}