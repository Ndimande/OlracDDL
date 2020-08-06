import 'package:dio/dio.dart';
import 'package:olracddl/models/crew_member.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/providers/dio.dart';

const String _baseUrl = AppConfig.DDM_URL + '/api/crews';
final Dio _dio = DioProvider().dio;
Future<List<CrewMember>> getCrewMembers() async {
  Response response;
  response = await _dio.get(_baseUrl);

  final List CrewMemberList = response.data['data'];
  final List<CrewMember> CrewMemberType = [];

  for (final Map CrewMemberData in CrewMemberList) {
    CrewMemberType.add(CrewMember(
      seamanId: CrewMemberData['seaman_book_identification'],
      firstName: CrewMemberData['firstname'],
      islandID: CrewMemberData['island_id'],
      middleName: CrewMemberData['middlenames'],
      lastName: CrewMemberData['lastname'],
      defaultRole: CrewMemberData['default_role_id'],
      secondaryRole: CrewMemberData['secondary_role_id'],
    ));
  }
  return CrewMemberType;
}
