import 'package:flutter/material.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/app_data.dart';
import 'package:olracddl/models/current_fishing_method.dart';
import 'package:olracddl/models/fishing_method.dart';
import 'package:olracddl/models/trip.dart';
import 'package:olracddl/repos/trip.dart';
import 'package:olracddl/screens/fishing_method.dart';
import 'package:olracddl/screens/start_trip.dart';
import 'package:olracddl/screens/trip.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/tiles/trip_tile.dart';

Future<Map<String, dynamic>> _load() async {
  final List<Trip> completedTrips =
      await TripRepo().all(where: 'ended_at IS NOT NULL');
  final List<Trip> incompleteTrips =
      await TripRepo().all(where: 'ended_at IS NULL');
  assert(incompleteTrips.length <= 1);
  final Trip activeTrip =
      incompleteTrips.isNotEmpty ? incompleteTrips.first : null;
  return {'completedTrips': completedTrips, 'activeTrip': activeTrip};
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Trip> _completedTrips = [];
  Trip _activeTrip;

  Future<void> _onPressStartTripButton() async {
    final FishingMethod method = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => FishingMethodScreen()));
    if (method != null) {
      await CurrentFishingMethod.set(method);
      await Navigator.push(
          context, MaterialPageRoute(builder: (_) => const StartTripScreen()));
    }

    setState(() {});
  }

  Future<void> _onPressActiveTripButton() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => TripScreen(_activeTrip.id)));
    setState(() {});
  }

  Widget _trips() {
    final List<Trip> allTrips = [];
    if (_activeTrip != null) {
      allTrips.add(_activeTrip);
    }
    allTrips.addAll(_completedTrips.reversed);

    if (allTrips.isEmpty) {
      return Center(
        child: Text('No Trips Recorded',
            style: Theme.of(context).textTheme.headline2),
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
              await Navigator.push(context,
                  MaterialPageRoute(builder: (_) => TripScreen(trip.id)));
              setState(() {});
            },
            listIndex: trip.id,
          ),
        );
      },
    );
  }

  Widget _body() {
    return WestlakeScaffold(
      drawer: _HomeDrawer(),
      body: Column(
        children: [
          Expanded(child: _trips()),
          if (_activeTrip == null)
            Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: StripButton(
                    labelText: 'Start New Trip',
                    onPressed: _onPressStartTripButton))
          else
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: StripButton(
                  labelText: 'Active Trip', onPressed: _onPressActiveTripButton),
            ),
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

Widget _drawerHeader() {
  return Builder(builder: (context) {
    final username = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Username',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 10,),
        Text(
          AppData.profile.username,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );

    return Container(
      height: 150,
      child: DrawerHeader(
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(0),
        child: Container(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        username,
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BackButton(color: Theme.of(context).primaryColor),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  });
}

class _HomeDrawer extends StatelessWidget {
  Widget _listTile({IconData iconData, String text, Function onTap}) {
    return Builder(
      builder: (BuildContext context) {
        return ListTile(
          leading:
              Icon(iconData, color: OlracColoursLight.olspsDarkBlue, size: 36),
          title: Text(text, style: Theme.of(context).textTheme.headline2),
          onTap: onTap,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Container(
        child: GradientBackground(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(color: const Color.fromRGBO(255, 255, 255, 0.5),
              margin: const EdgeInsets.only(bottom: 20),
                child: _drawerHeader()),
              Column(
                children: [
                  _listTile(
                    iconData: Icons.history,
                    text: 'Trip History',
                    onTap: () => null,
                  ),
                  _listTile(
                    iconData: Icons.settings,
                    text: 'Settings',
                    onTap: () => null,
                  ),
                  _listTile(
                    iconData: Icons.info,
                    text: 'About',
                    onTap: () => null,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
