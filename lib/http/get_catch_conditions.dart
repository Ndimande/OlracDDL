import 'package:dio/dio.dart';
import 'package:olracddl/models/catch_condition.dart';
import 'package:olracddl/models/port.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/providers/dio.dart';
import 'package:olracddl/repos/port.dart';

const String _baseUrl = AppConfig.DDM_URL + '/api/conditions';
final Dio _dio = DioProvider().dio;
Future<List<CatchCondition>>  getCatchConditions() async{
  Response response;
  response = await _dio.get(_baseUrl);

  final List portList = response.data['data'];
  final  List<CatchCondition> catchConditionType = [];

  for(final Map catchConditionData in portList){
    catchConditionType.add(CatchCondition(name: catchConditionData['displayname'],namePortuguese: catchConditionData['displayname_portuguese']));

  }
  return catchConditionType;
}