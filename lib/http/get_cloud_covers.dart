import 'package:dio/dio.dart';
import 'package:olracddl/models/cloud_cover.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/providers/dio.dart';
import 'package:olracddl/repos/cloud_cover.dart';

const String _baseUrl = AppConfig.DDM_URL + '/api/cloud_covers';
final Dio _dio = DioProvider().dio;

Future<List<CloudCover>> getCloudCovers() async{
  Response response;
  response = await _dio.get(_baseUrl);

  final List cloudCoverList = response.data['data'];
  final  List<CloudCover> CloudCovers = [];

  for(final Map CloudCoverData in cloudCoverList){
    CloudCovers.add(CloudCover(name: CloudCoverData['displayname']));

  }
  return CloudCovers;
}