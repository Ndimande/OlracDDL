part of 'trip_screen.dart';

Future<Map> _load(int tripID) async {
  final Trip trip = await TripRepo().find(tripID);
  print('XXXXXXXXXXXXXXXXXXXXXX');
  print(trip.fishingSets.length);
  return {
    'trip': trip,
  };
}