
import 'package:dio/dio.dart';
import 'package:olracddl/models/fishing_area.dart';
import 'package:olracddl/models/fishing_method.dart';
import 'package:olracddl/models/vessel.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/providers/dio.dart';
import 'package:olracddl/repos/vessel.dart';

import '../get_lookup_data.dart';

const String _baseUrl = AppConfig.DDM_URL + '/api/gears';
final Dio _dio = DioProvider().dio;

Future<List<FishingMethod>> getFishingMethods() async {
  Response response;
  response = await _dio.get(_baseUrl);

  final List fishingMethodsList = response.data['data'];
  final List<FishingMethod> fishingMethods = [];
  for(final Map fishingMethodData in fishingMethodsList){
    fishingMethods.add(FishingMethod(name: fishingMethodData['displayname']));
  }

  return fishingMethods;
}