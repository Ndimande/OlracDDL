import 'package:dio/dio.dart';
import 'package:olracddl/models/sea_condition.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/providers/dio.dart';
import 'package:olracddl/repos/sea_condition.dart';

const String _baseUrl = AppConfig.DDM_URL + '/api/conditions';
final Dio _dio = DioProvider().dio;
Future<List<SeaCondition>>  getSeaConditions() async{
  Response response;
  response = await _dio.get(_baseUrl);

  final List seaConditionList = response.data['data'];
  final  List<SeaCondition> seaConditionType = [];

  for(final Map seaConditionData in seaConditionList){
    seaConditionType.add(SeaCondition(name: seaConditionData['displayname'] ,imageString: seaConditionData['code'],namePortuguese: seaConditionData['displayname_portuguese'] )); //This need to be evaluated...Second Parameter!!!!!
  }
  return seaConditionType;
}