import 'package:dio/dio.dart';
import 'package:olracddl/models/species.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/providers/dio.dart';
import 'package:olracddl/repos/species.dart';

const String _baseUrl = AppConfig.DDM_URL + 'api/species';
final Dio _dio = DioProvider().dio;
Future<List<Species>>  getMoonPhase() async{
  Response response;
  response = await _dio.get(_baseUrl);

  final List speciesList = response.data['data'];
  final  List<Species> speciesType = [];

  for(final Map speciesData in speciesList){
    speciesType.add(Species(commonName: speciesData['displayname']));

  }
  return speciesType;
}