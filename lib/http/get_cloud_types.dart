import 'package:dio/dio.dart';
import 'package:olracddl/models/cloud_type.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/providers/dio.dart';
import 'package:olracddl/repos/cloud_type.dart';

const String _baseUrl = AppConfig.DDM_URL + '/api/cloud_types';
final Dio _dio = DioProvider().dio;
Future<List<CloudType>>  getCloudTypes() async{
  Response response;
  response = await _dio.get(_baseUrl);

  final List cloudTypeList = response.data['data'];
  final  List<CloudType> cloudType = [];

  for(final Map cloudTypeData in cloudTypeList){
    cloudType.add(CloudType(name: cloudTypeData['displayname'], imageString: null));

  }
  return cloudType;
}