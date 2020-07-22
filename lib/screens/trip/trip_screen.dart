import 'package:flutter/material.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/disposals.dart';
import 'package:olracddl/models/fishing_set.dart';
import 'package:olracddl/models/trip.dart';
import 'package:olracddl/repos/trip.dart';
import 'package:olracddl/screens/marine_life.dart';
import 'package:olracddl/screens/retained.dart';
import 'package:olracddl/screens/start_set_screen.dart';
import 'package:olracddl/screens/trip/trip_section.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/end_trip_information_dialog.dart';
import 'package:olracddl/widgets/fishing_set_tile.dart';

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
    final Map result = await showDialog(context: context, builder: (_) => EndTripInformationDialog());

    if (result == null) {
      return;
    }

    trip.endedAt = result['endedAt'];
    trip.endLocation = result['endLocation'];
    await TripRepo().store(trip);
    Navigator.pop(context);
  }

  Future<void> _onPressStartFishingSet() async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => StartSetScreen(_trip.id)));
    setState(() {});
  }

  Widget _endTripButton() {
    return StripButton(
      color: OlracColoursLight.olspsRed,
      labelText: 'End Trip',
      onPressed: _trip.endedAt != null ? null : _onPressEndTrip,
    );
  }

  Widget _startFishingSet() {
    return StripButton(
      labelText: 'Start Set',
      onPressed: _onPressStartFishingSet,
    );
  }

  Widget _noFishingActivities() {
    return Center(
      child: Text(
        'No Fishing Activities\nRecorded',
        style: Theme.of(context).textTheme.headline2,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _fishingSetList() {
    return ListView.builder(
        itemCount: _trip.fishingSets.length,
        itemBuilder: (context, int index) {
          final FishingSet fishingSet = _trip.fishingSets[index];

          return FishingSetTile(
            fishingSet: fishingSet,
            indexNumber: index,
            onPressDisposal: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (_) => DisposalsScreen(tripID: _trip.id, fishingSetID: fishingSet.id)));
            },
            onPressMarineLife: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (_) => MarineLifeScreen(tripID: _trip.id, fishingSetID: fishingSet.id)));
            },
            onPressRetained: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RetainedScreen(tripID: _trip.id, setID: fishingSet.id)),
              );
            },
          );
        });
  }

  Widget _body() {
    return Column(
      children: [
        TripSection(trip: _trip),
        Expanded(
          child: _trip.fishingSets.isEmpty ? _noFishingActivities() : _fishingSetList(),
        ),
        if (_trip.isActive) _bottomButtons(),
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
          actions: const [IconButton(icon: Icon(Icons.edit))],
          body: _body(),
        );
      },
    );
  }
}
