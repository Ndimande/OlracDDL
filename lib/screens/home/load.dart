part of 'home.dart';

Future<Map<String, dynamic>> _load() async {
  final List<Trip> completedTrips = await TripRepo().all(where: 'ended_at IS NOT NULL');
  final List<Trip> incompleteTrips = await TripRepo().all(where: 'ended_at IS NULL');
  assert(incompleteTrips.length <= 1);
  final Trip activeTrip = incompleteTrips.isNotEmpty ? incompleteTrips.first : null;
  return {'completedTrips': completedTrips, 'activeTrip': activeTrip};
}
