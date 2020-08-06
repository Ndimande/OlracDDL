// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:olrac_widgets/olrac_widgets.dart';
// import 'package:olracddl/localization/app_localization.dart';
// import 'package:olracddl/theme.dart';
// import 'package:geolocation/geolocation.dart';
// import "package:latlong/latlong.dart" as latLng;

// import 'package:flutter_map/flutter_map.dart';

// class MapScreen extends StatefulWidget {

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   List<LocationResult> locations = [];
//   LocationResult locationMap = null; 
//   StreamSubscription<LocationResult> streamSubscription;
//   bool trackLocation = false;

//   @override
//   void initState() {
//     super.initState();
//     checkGps();

//     trackLocation = false;
//     locations = [];
//     locationMap =null; 
//   }

//   getLocations() {
//     if (trackLocation) {
//       setState(() => false);
//       streamSubscription.cancel();
//       streamSubscription = null;
//       locations = []; 
//       locationMap = null; 
//     } else {
//       setState(() => true);

//       streamSubscription = Geolocation.locationUpdates(
//         accuracy: LocationAccuracy.best,
//         displacementFilter: 0.0,
//         inBackground: false,
//       ).listen((result) {
//         final location = result;
//         setState(() {
//           locations.add(location);
//           locationMap = locationMap; 
//         });
//       });

//       streamSubscription.onDone(() => setState(() {
//             trackLocation = false;
//           }));
//     }
//   }

//   checkGps() async {
//     final GeolocationResult result = await Geolocation.isLocationOperational();
//     if (result.isSuccessful) {
//       print('Success');
//     } else {
//       print('failed');
//     }
//   }

//   MapController controller = MapController();

// buildMap() {
//   checkGps().then((response){
//     if(response.isSuccessful) {
//       response.listen((value) {
//         controller.move(latLng.LatLng(value.location.latitude, value.location.longitude), 15.0);
//       });
//     }
//   });
// }

//   @override
//   Widget build(BuildContext context) {
//     return WestlakeScaffold(
//       actions: [FlatButton(
//         child: const Text('Get Location'),
//         onPressed: getLocations,
//       ),],
//       leading: IconButton(
//         icon: const Icon(
//           Icons.arrow_back,
//           size: 30,
//         ),
//         onPressed: () => Navigator.pop(context),
//       ),
//       body: Center(
//         child: Column(
//            children: [
//           Container(
//               height: 200, 
//               child: ListView(
//                 children: [
//                   Image.network(locationMap == null? '' :
//                     'https://maps.googleapis.com/maps/api/staticmap?center=')
//                 ]
//               ),
//             ),
         
//             Container(
//               height: 300, 
//               child: ListView(
//                 children: locations.map((loc) => ListTile(
//                   title: Text('You are here: ${loc.location.longitude} : ${loc.location.latitude}'),
//                   subtitle: Text('Your Altitude is ${loc.location.altitude}'),
//                 )).toList(),
//               ),
//             ),
//           ],
//         ),
//       ),
//       // FlutterMap(mapController: controller,
//       // options: MapOptions(center: BuildMap(), minZoom: 5.0),
//       // layers: [
//       //   TileLayerOptions(
//       //     urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//       //     subdomains: ['a', 'b', 'c']
//       //   )
//       // ],)
//     );
//   }
// }

// // FutureBuilder(
// //       future: DisposalRepo().all(where: 'fishing_set_id = ${widget.fishingSetID}'),
// //       builder: (context, AsyncSnapshot<List<Disposal>> snapshot) {
// //         if (snapshot.hasError) {
// //           throw snapshot.error;
// //         }
// //         if (!snapshot.hasData) {
// //           return const CircularProgressIndicator();
// //         }

// //         if (snapshot.data.isEmpty) {
// //           return _noDisposals();
// //         }

// //         return _disposalsList(snapshot.data);
// //       },
// //     );
