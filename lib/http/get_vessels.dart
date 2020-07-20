
import 'package:dio/dio.dart';
import 'package:olracddl/models/vessel.dart';
import 'package:olracddl/providers/dio.dart';

Future<List<Vessel>> getVessels() async {

   final Dio dio = DioProvider().dio;

   Response response;
   response = await dio.get("https://azores.olracddm.com/api/vessels");
   print(response.data.toString());

}