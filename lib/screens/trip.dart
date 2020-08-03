import 'package:flutter/material.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/localization/app_localization.dart';
import 'package:olracddl/models/current_fishing_method.dart';
import 'package:olracddl/models/fishing_method.dart';
import 'package:olracddl/models/fishing_set.dart';
import 'package:olracddl/models/trip.dart';
import 'package:olracddl/repos/fishing_set.dart';
import 'package:olracddl/repos/trip.dart';
import 'package:olracddl/screens/disposals/list_disposals.dart';
import 'package:olracddl/screens/fishing_method.dart';
import 'package:olracddl/screens/marine_life/list_marine_life.dart';
import 'package:olracddl/screens/retained/list_retained.dart';
import 'package:olracddl/screens/start_set.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/circle_button.dart';
import 'package:olracddl/widgets/dialogs/end_set_information_dialog.dart';
import 'package:olracddl/widgets/dialogs/end_trip_information_dialog.dart';
import 'package:olracddl/widgets/elapsed_counter.dart';
import 'package:olracddl/widgets/numbered_boat.dart';
import 'package:olracddl/widgets/svg_icon.dart';
import 'package:olracddl/widgets/tiles/fishing_set_tile.dart';

import 'home.dart';

Future<Map> _load(int tripID) async {
  final Trip trip = await TripRepo().find(tripID);
  return {
    'trip': trip,
  };
}

class TripScreen extends StatefulWidget {
  const TripScreen(this.tripID);

  final int tripID;

  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  Trip _trip;

  FishingSet get activeSet {
    return _trip.fishingSets
        .firstWhere((FishingSet fs) => fs.isActive, orElse: () => null);
  }

  Future<void> _onPressEndTrip() async {
    final Trip trip = await TripRepo().find(widget.tripID);
    final Map result = await showDialog(
        context: context, builder: (_) => EndTripInformationDialog());

    if (result == null) {
      return;
    }

    trip.endedAt = result['endedAt'];
    trip.endLocation = result['endLocation'];
    await TripRepo().store(trip);
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  Future<void> _onPressStartFishingSet() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => StartSetScreen(_trip.id)));
    setState(() {});
  }

  Future<void> _onPressEndFishingSet() async {
    // End set
    final Map result = await showDialog(
        context: context,
        builder: (_) {
          return EndSetInformationDialog();
        });
    final DateTime endedAt = result['endedAt'];
    final Location endLocation = result['endLocation'];
    final int hooks = result['hooks'];
    final int traps = result['traps'];
    final int linesUsed = result['linesUsed'];

    final FishingSet updatedSet = activeSet;
    updatedSet.endedAt = endedAt;
    updatedSet.endLocation = endLocation;
    updatedSet.hooks = hooks;
    updatedSet.traps = traps;
    updatedSet.linesUsed = linesUsed;
    await FishingSetRepo().store(updatedSet);
    setState(() {});
  }

  Widget _endTripButton() {
    if (activeSet != null) {
      return StripButton(
        color: OlracColoursLight.olspsGrey,
        labelText: AppLocalizations.of(context).getTranslatedValue('end_trip'),
        onPressed: null,
      );
    }
    return StripButton(
      color: OlracColoursLight.olspsRed,
      labelText: AppLocalizations.of(context).getTranslatedValue('end_trip'),
      onPressed: _trip.endedAt != null ? null : _onPressEndTrip,
    );
  }

  Widget _fishingSetButton() {
    if (activeSet != null) {
      return StripButton(
        labelText: AppLocalizations.of(context).getTranslatedValue('end_set'),
        onPressed: _onPressEndFishingSet,
      );
    }
    return StripButton(
      labelText: AppLocalizations.of(context).getTranslatedValue('start_set'),
      onPressed: _onPressStartFishingSet,
    );
  }

  Widget _noFishingActivities() {
    return Center(
      child: Text(
        AppLocalizations.of(context)
            .getTranslatedValue('no_fishing_activities_recorded'),
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
          longPressFunction: () {},
          fishingSet: fishingSet,
          indexNumber: index,
          onPressDisposal: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ListDisposalsScreen(
                        tripID: _trip.id, fishingSetID: fishingSet.id)));
          },
          onPressMarineLife: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ListMarineLifeScreen(
                        tripID: _trip.id, fishingSetID: fishingSet.id)));
          },
          onPressRetained: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ListRetainedScreen(
                      tripID: _trip.id, setID: fishingSet.id)),
            );
          },
        );
      },
    );
  }

  Widget _body() {
    return Column(
      children: [
        _TripDetails(trip: _trip),
        Expanded(
          child: _trip.fishingSets.isEmpty
              ? _noFishingActivities()
              : _fishingSetList(),
        ),
        if (_trip.isActive) _bottomButtons(),
      ],
    );
  }

  Widget _bottomButtons() {
    return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_fishingSetButton(), _endTripButton()]));
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
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          //actions: const [IconButton(icon: Icon(Icons.edit))],
          body: _body(),
        );
      },
    );
  }
}

class _TripDetails extends StatelessWidget {
  final Trip trip;
  final bool hasActiveHaul;

  const _TripDetails({
    @required this.trip,
    this.hasActiveHaul = false,
  });

  Widget _started() {
    return Builder(builder: (BuildContext context) {
      return Row(
        children: [
          Text(
              '${AppLocalizations.of(context).getTranslatedValue('started')}: ',
              style: Theme.of(context).textTheme.headline6),
          Text(friendlyDateTime(trip.startedAt),
              style: Theme.of(context).textTheme.headline6)
        ],
      );
    });
  }

  Widget _ended() {
    return Builder(builder: (BuildContext context) {
      return Row(
        children: [
          Text('${AppLocalizations.of(context).getTranslatedValue('ended')}: ',
              style: Theme.of(context).textTheme.headline6),
          Text(friendlyDateTime(trip.startedAt),
              style: Theme.of(context).textTheme.headline6)
        ],
      );
    });
  }

  Widget _duration() {
    return Builder(builder: (BuildContext context) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              '${AppLocalizations.of(context).getTranslatedValue('duration')}: ',
              style: Theme.of(context).textTheme.headline6),
          ElapsedCounter(
              style: Theme.of(context).textTheme.headline6,
              startedDateTime: trip.startedAt),
        ],
      );
    });
  }

  // Widget _locationButton() {
  //   return Container(
  //     margin: const EdgeInsets.only(left: 20),
  //     child: IconButton(
  //       icon: Image.asset('assets/images/location_icon.png'),
  //       onPressed: () {},
  //     ),
  //   );
  // }

  StatefulBuilder _fishingMethodButton() {
    Future<FishingMethod> currentFM() async {
      return await CurrentFishingMethod.get();
    }

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return FutureBuilder(
          future: currentFM(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            final FishingMethod fm = snapshot.data;
            return ClipOval(
              child: Material(
                color: OlracColoursLight.olspsDarkBlue, // button color
                child: InkWell(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child:
                          SvgIcon(assetPath: fm.svgPath, color: Colors.white),
                    ),
                  ),
                  onTap: () async {
                    final FishingMethod method = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => FishingMethodScreen()));
                    if (method != null) {
                      setState(() {});
                      CurrentFishingMethod.set(method);
                    }
                  },
                ),
              ),
            );

            // IconButton(
            //   icon: SvgIcon(
            //       assetPath: fm.svgPath, color: OlracColoursLight.olspsDarkBlue),
            //   onPressed: () async {
            //     final FishingMethod method = await Navigator.push(context,
            //         MaterialPageRoute(builder: (_) => FishingMethodScreen()));
            //     if (method != null) {
            //       CurrentFishingMethod.set(method);
            //     }
            //   },
            // );
          },
        );
      },
    );
  }

  Widget tripInfo() {
    return Builder(builder: (BuildContext context) {
      return Container(
        margin: const EdgeInsets.only(left: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _started(),
                if (trip.isActive) _duration() else _ended(),
              ],
            ),
            SizedBox(width: 10),
            //_locationButton(),
            _fishingMethodButton(),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              NumberedBoat(number: trip.id),
              const SizedBox(width: 5),
              tripInfo(),
            ],
          ),
        ],
      ),
    );
  }
}
