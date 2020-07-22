import 'package:flutter/material.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/models/current_fishing_method.dart';
import 'package:olracddl/models/fishing_method.dart';
import 'package:olracddl/models/trip.dart';
import 'package:olracddl/repos/trip.dart';
import 'package:olracddl/screens/fishing_method.dart';
import 'package:olracddl/screens/home/drawer.dart';
import 'package:olracddl/screens/start_trip_screen.dart';
import 'package:olracddl/screens/trip/trip_screen.dart';
import 'package:olracddl/widgets/trip_tile.dart';

part 'load.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Trip> _completedTrips = [];
  Trip _activeTrip;

  Future<void> _onPressStartTripButton() async {
    final FishingMethod method = await Navigator.of(context).push(MaterialPageRoute(builder:(_) => FishingMethodScreen()));

    await CurrentFishingMethod.set(method);
    await Navigator.push(context, MaterialPageRoute(builder:(_) => const StartTripScreen()));
    setState(() {});
  }

  Future<void> _onPressActiveTripButton() async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => TripScreen(_activeTrip.id)));
  }

  Widget _trips() {
    final List<Trip> allTrips = [];
    if (_activeTrip != null) {
      allTrips.add(_activeTrip);
    }
    allTrips.addAll(_completedTrips);

    if (allTrips.isEmpty) {
      return Center(
        child: Text('No Trips Recorded', style: Theme.of(context).textTheme.headline2),
      );
    }
    return ListView.builder(
      itemCount: allTrips.length,
      itemBuilder: (BuildContext context, int index) {
        final Trip trip = allTrips[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TripTile(
            trip: trip,
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (_) => TripScreen(trip.id)));
            },
            listIndex: trip.id,
          ),
        );
      },
    );
  }

  Widget _body() {
    return WestlakeScaffold(
      drawer: MainDrawer(),
      body: Column(
        children: [
          Expanded(child: _trips()),
          if (_activeTrip == null)
            StripButton(labelText: 'Start New Trip', onPressed: _onPressStartTripButton)
          else
            StripButton(labelText: 'Active Trip', onPressed: _onPressActiveTripButton),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _load(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          throw snapshot.error;
        }
        if (!snapshot.hasData) {
          return const Scaffold();
        }

        _completedTrips = snapshot.data['completedTrips'] as List<Trip>;
        _activeTrip = snapshot.data['activeTrip'];
        return _body();
      },
    );
  }
}
