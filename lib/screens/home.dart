import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/app_data.dart';
import 'package:olracddl/localization/app_localization.dart';
import 'package:olracddl/models/current_fishing_method.dart';
import 'package:olracddl/models/disposal.dart';
import 'package:olracddl/models/fishing_method.dart';
import 'package:olracddl/models/fishing_set.dart';
import 'package:olracddl/models/marine_life.dart';
import 'package:olracddl/models/retained_catch.dart';
import 'package:olracddl/models/skipper.dart';
import 'package:olracddl/models/trip.dart';
import 'package:olracddl/post_data.dart';
import 'package:olracddl/repos/disposal.dart';
import 'package:olracddl/repos/fishing_set.dart';
import 'package:olracddl/repos/marine_life.dart';
import 'package:olracddl/repos/retained_catch.dart';
import 'package:olracddl/repos/skipper.dart';
import 'package:olracddl/repos/trip.dart';
import 'package:olracddl/screens/fishing_method.dart';
import 'package:olracddl/screens/settings_screen.dart';
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
        child: Text(
            AppLocalizations.of(context)
                .getTranslatedValue('no_trips_recorded'),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_activeTrip == null)
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: StripButton(
                        labelText: AppLocalizations.of(context)
                            .getTranslatedValue('start_new_trip'),
                        onPressed: _onPressStartTripButton))
              else
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: StripButton(
                      labelText: AppLocalizations.of(context)
                          .getTranslatedValue('active_trip'),
                      onPressed: _onPressActiveTripButton),
                ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: StripButton(
                    color: OlracColoursLight.olspsHighlightBlue,
                    labelText: 'Upload',
                    onPressed: upload,
                    disabled: _completedTrips.isEmpty ? true : false,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> uploadTrip(Trip trip) async {
    for (final trip in _completedTrips) {
      if (!trip.isUploaded) {
        trip.uploadedAt = DateTime.now().toUtc();
        final TripRepo tripRepo = TripRepo();
        final Map<String, dynamic> toTripModel = await postTrip(trip);
        if (trip.isUploaded && toTripModel != null) {
          print(trip.isUploaded);
          await tripRepo.store(trip);
        }
      }
    }
    if (_completedTrips
        .where((element) => !element.isUploaded)
        .toList()
        .isEmpty) {
      setState(() {});
    }
  }

  Future<void> uploadSet(Trip trip) async {
    final FishingSetRepo fishingSetRepo = FishingSetRepo();
    final DisposalRepo disposalRepo = DisposalRepo();
    final RetainedCatchRepo retainedCatchRepo = RetainedCatchRepo();
    final MarineLifeRepo marineLifeRepo = MarineLifeRepo();
    for (final trip in _completedTrips) {
      trip.fishingSets =
          await fishingSetRepo.all(where: 'trip_id = ${trip.id}');
      for (final FishingSet fishingSet in trip.fishingSets) {
        final Map<String, dynamic> toFishingSet =
            await postFishingSet(fishingSet);
        if (toFishingSet != null && trip.isUploaded) {
          final List<Disposal> toDisposals = await disposalRepo.all(
              where: 'fishing_set_id = ${fishingSet.id}');
          for (final Disposal disposal in toDisposals) {
            final Map<String, dynamic> toDisposal =
                await postDisposal(disposal);
          }

          final List<RetainedCatch> retainedCatches = await retainedCatchRepo.all(
              where: 'fishing_set_id = ${fishingSet.id}');


          for (final RetainedCatch retainedCatch in retainedCatches) {
            final Map<String, dynamic> retainedCatches =
            await postRetainedCatch(retainedCatch);
          }

//           final List<MarineLife> marineLife = await marineLifeRepo.all(
//              where: 'fishing_set_id = ${fishingSet.id}');
//
//          for (final MarineLife marine in marineLife) {
//            final Map<String, dynamic> marines =
//            await postMarineLife(marine);
//          }
        }
      }
    }
  }


  Future<void> uploadDisposal(Trip trip) async {}

  Future<void> upload() async {
    for (final trip in _completedTrips) {
    //  testSkippers();
      uploadTrip(trip);
      uploadSet(trip);
    }
  }

  Future<void> testSkippers()async{
    final List<Skipper> skippers = await SkipperRepo().all(
        where: 'seaman_id = ${'4512'}');
    for(Skipper skipper in skippers ){
      print(skipper.name);
    }
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
        Text(
          AppLocalizations.of(context).getTranslatedValue('username'),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
        ),
        const SizedBox(
          height: 10,
        ),
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
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
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
              Container(
                  color: const Color.fromRGBO(255, 255, 255, 0.5),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: _drawerHeader()),
              Column(
                children: [
                  _listTile(
                    iconData: Icons.history,
                    text: AppLocalizations.of(context)
                        .getTranslatedValue('trip_history'),
                    onTap: () => null,
                  ),
                  _listTile(
                    iconData: Icons.settings,
                    text: AppLocalizations.of(context)
                        .getTranslatedValue('settings'),
                    onTap: () async => await Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => SettingsScreen())),
                  ),
                  _listTile(
                    iconData: Icons.info,
                    text: AppLocalizations.of(context)
                        .getTranslatedValue('about'),
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
