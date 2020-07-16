import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/models/trip.dart';
import 'package:olracddl/repos/trip.dart';
import 'package:olracddl/screens/trip/trip_section.dart';
import 'package:olracddl/screens/start_set_screen.dart';
import 'package:olracddl/theme.dart';

part 'load.dart';

class TripScreen extends StatefulWidget {
  const TripScreen(this.tripID);

  final int tripID;

  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  Trip _trip;

  Future<void> _onPressEndTrip() async {
    final Trip trip = await TripRepo().find(widget.tripID);
    trip.endedAt = DateTime.now();
    final Position p = await Geolocator().getCurrentPosition();
    trip.endLocation = Location(latitude: p.latitude, longitude: p.longitude);
    await TripRepo().store(trip);
    Navigator.pop(context);
  }

  Future<void> _onPressStartFishingSet() async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => StartSetScreen()));
  }

  Widget _endTripButton() {
    return StripButton(
      color: OlracColoursLight.olspsRed,
      labelText: 'End Trip',
      onPressed: _onPressEndTrip,
    );
  }

  Widget _startFishingSet() {
    return StripButton(
      labelText: 'Start Fishing Set',
      onPressed: _onPressStartFishingSet,
    );
  }

  Widget _body() {
    return Column(
      children: [
        TripSection(trip: _trip),
        Expanded(
          child: Center(
            child: Text(
              'No Fishing Activities\nRecorded',
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        _bottomButtons(),
      ],
    );
  }

  Widget _bottomButtons() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [_startFishingSet(), _endTripButton()]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _load(widget.tripID),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          throw snapshot.error;
        }
        if (!snapshot.hasData) {
          return const Scaffold();
        }
        _trip = snapshot.data['trip'];

        return WestlakeScaffold(
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
            )
          ],
          body: _body(),
        );
      },
    );
  }
}
