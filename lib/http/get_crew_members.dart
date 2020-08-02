import 'package:dio/dio.dart';
import 'package:olracddl/models/crew_member.dart';
import 'package:olracddl/models/species.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/providers/dio.dart';
import 'package:olracddl/repos/species.dart';

const String _baseUrl = AppConfig.DDM_URL + '/api/crews';
final Dio _dio = DioProvider().dio;
Future<List<CrewMember>>  getCrewMembers() async{
  Response response;
  response = await _dio.get(_baseUrl);

  final List CrewMemberList = response.data['data'];
  final  List<CrewMember> CrewMemberType = [];

  for(final Map CrewMemberData in CrewMemberList){
    CrewMemberType.add(CrewMember(seamanId: CrewMemberData['seaman_book_identification'], firstName : CrewMemberData['firstname'], middleName: CrewMemberData['middlenames'],lastName: CrewMemberData['lastname'], ));

  }
  return CrewMemberType;
}