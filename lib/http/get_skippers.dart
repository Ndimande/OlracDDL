import 'package:dio/dio.dart';
import 'package:olracddl/models/crew_member.dart';
import 'package:olracddl/models/skipper.dart';
import 'package:olracddl/models/species.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/providers/dio.dart';
import 'package:olracddl/repos/species.dart';

const String _baseUrl = AppConfig.DDM_URL + '/api/crews';
final Dio _dio = DioProvider().dio;
Future<List<Skipper>>  getSkippers() async{
  Response response;
  response = await _dio.get(_baseUrl);

  final List skipperList = response.data['data'];
  final  List<Skipper> skipperType = [];

  for(final Map CrewMemberData in skipperList){
    skipperType.add(Skipper(seamanId: CrewMemberData['seaman_book_identification'], firstName : CrewMemberData['firstname'], middleName: CrewMemberData['middlenames'],lastName: CrewMemberData['lastname'], ));

  }
  return skipperType;
}