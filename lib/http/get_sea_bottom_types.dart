import 'package:dio/dio.dart';
import 'package:olracddl/models/sea_bottom_type.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/providers/dio.dart';
import 'package:olracddl/repos/sea_bottom_type.dart';

const String _baseUrl = AppConfig.DDM_URL + 'api/bottom_types';
final Dio _dio = DioProvider().dio;
Future<List<SeaBottomType>>  getSeaBottomTypes() async{
  Response response;
  response = await _dio.get(_baseUrl);

 final List seaBottomList = response.data['data'];
 final  List<SeaBottomType> seaBottomType = [];

  for(final Map SeaBottomTypeData in seaBottomList){
    seaBottomType.add(SeaBottomType(name: SeaBottomTypeData['displayname']));

  }
  return seaBottomType;
}