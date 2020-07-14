part of 'home.dart';

Future<Map<String, dynamic>> _load() async {
  final List<Trip> completedTrips = await TripRepo().all(where: 'ended_at IS NOT NULL');

  return {
    'completedTrips': completedTrips,
  };
}
