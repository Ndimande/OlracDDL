import 'package:flutter/material.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/models/trip.dart';
import 'package:olracddl/repos/trip.dart';
import 'package:olracddl/screens/fishing_method.dart';
import 'package:olracddl/screens/home/drawer.dart';
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
    await Navigator.of(context).push(MaterialPageRoute(builder: (_) => FishingMethodScreen()));
  }

  Future<void> _onPressActiveTripButton() async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (_) => TripScreen(_activeTrip.id)));
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
          return TripTile(
            setEntries: allTrips[index].fishingSets.length,
            tripNumber: index,
            tripWeight: 5,
            tripDuration: Duration(minutes: 1),

          );
          return Text(allTrips[index].startedAt.toIso8601String());
        });
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
