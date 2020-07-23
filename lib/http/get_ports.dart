import 'package:dio/dio.dart';
import 'package:olracddl/models/port.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/providers/dio.dart';
import 'package:olracddl/repos/port.dart';

const String _baseUrl = AppConfig.DDM_URL + '/api/ports';
final Dio _dio = DioProvider().dio;
Future<List<Port>>  getPorts() async{
  Response response;
  response = await _dio.get(_baseUrl);

  final List portList = response.data['data'];
  final  List<Port> portType = [];

  for(final Map portData in portList){
    portType.add(Port(name: portData['displayname']));

  }
  return portType;
}