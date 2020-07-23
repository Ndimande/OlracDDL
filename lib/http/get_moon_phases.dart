import 'package:dio/dio.dart';
import 'package:olracddl/models/moon_phase.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/providers/dio.dart';
import 'package:olracddl/repos/moon_phase.dart';

const String _baseUrl = AppConfig.DDM_URL + '/api/moon_phases';
final Dio _dio = DioProvider().dio;
Future<List<MoonPhase>>  getMoonPhases() async{
  Response response;
  response = await _dio.get(_baseUrl);

  final List moonPhaseList = response.data['data'];
  final  List<MoonPhase> moonPhaseType = [];

  for(final Map moonPhaseData in moonPhaseList){
    moonPhaseType.add(MoonPhase(name: moonPhaseData['displayname']));

  }
  return moonPhaseType;
}