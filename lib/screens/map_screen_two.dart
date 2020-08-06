// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:olrac_widgets/olrac_widgets.dart';
// import 'package:olracddl/localization/app_localization.dart';
// import 'package:olracddl/theme.dart';
// import "package:latlong/latlong.dart" as latLng;

// import 'package:flutter_map/flutter_map.dart';

// class MapScreenTwo extends StatefulWidget {
//   @override
//   _MapScreenTwoState createState() => _MapScreenTwoState();
// }

// class _MapScreenTwoState extends State<MapScreenTwo> {
//   MapController controller = MapController();
//   Position p;


//   Future<Position> getLocation() async {
//     final Position p = await Geolocator().getCurrentPosition();
//     return p;
//   }

//   buildMap() {
//     getLocation().then((result) {
//       if (result != null) {
//         controller.move(latLng.LatLng(result.latitude, result.longitude), 15.0);
//       } else {
//         print('GPS not working');
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WestlakeScaffold(
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             size: 30,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         body: FlutterMap(
//           mapController: controller,
//           options: MapOptions(center: buildMap(), minZoom: 15.0, maxZoom: 10.0),
//           layers: [
//             TileLayerOptions(
//                 urlTemplate:
//                     'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                 subdomains: ['a', 'b', 'c']),
//             MarkerLayerOptions(
//               markers: [
//                 Marker(
//                   width: 300.0,
//                   height: 300.0,
//                   point: latLng.LatLng(-33.9825844833, 18.466919648),
//                   builder: (ctx) => Container(
//                     child: Text('Hello'),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ));
//   }
// }

