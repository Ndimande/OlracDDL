
import 'package:dio/dio.dart';
import 'package:olracddl/models/vessel.dart';
import 'package:olracddl/app_config.dart';
import 'package:olracddl/providers/dio.dart';
import 'package:olracddl/repos/vessel.dart';

import '../get_lookup_data.dart';

const String _baseUrl = AppConfig.DDM_URL + '/api/vessels';
final Dio _dio = DioProvider().dio;

Future<List<Vessel>> getVessels() async {
   Response response;
   response = await _dio.get(_baseUrl);

   final List vesselList = response.data['data'];
   final List<Vessel> vessels = [];
   for(final Map vesselData in vesselList){
      vessels.add(Vessel(name: vesselData['vessel_name']));
      //await VesselRepo().store(Vessel(name: vesselData['vessel_name']));
   }

   return vessels;
}