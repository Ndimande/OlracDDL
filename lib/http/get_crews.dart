import 'package:dio/dio.dart';
import 'package:olracddl/models/crew.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/providers/dio.dart';
import 'package:olracddl/repos/crew.dart';

const String _baseUrl = AppConfig.DDM_URL + 'api/crews';
final Dio _dio = DioProvider().dio;
Future<List<Crew>>  getMoonPhase() async{
  Response response;
  response = await _dio.get(_baseUrl);

  final List<Map> crewList = response.data['data'];
  final  List<Crew> crewType = [];

  for(final Map moonPhaseData in crewList){
    crewType.add(Crew(name: moonPhaseData['displayname']));

  }
  return crewType;
}