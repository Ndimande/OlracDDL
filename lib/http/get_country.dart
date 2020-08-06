import 'package:dio/dio.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/models/country.dart';
import 'package:olracddl/providers/dio.dart';

const String _baseUrl = AppConfig.DDM_URL + '/api/nationalities';
final Dio _dio = DioProvider().dio;
Future<List<Country>>  getCountries() async{
  Response response;
  response = await _dio.get(_baseUrl);

  final List countryList = response.data['data'];
  final  List<Country> countryType = [];

  for(final Map countryTypeData in countryList){
    countryType.add(Country(name: countryTypeData['displayname'], countryPortuguese: countryTypeData['displayname_portuguese'])); //ask!!!!!!!!

  }
  return countryType;
}