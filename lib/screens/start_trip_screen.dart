import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/models/current_fishing_method.dart';
import 'package:olracddl/models/fishing_method.dart';
import 'package:olracddl/models/port.dart';
import 'package:olracddl/models/trip.dart';
import 'package:olracddl/models/vessel.dart';
import 'package:olracddl/repos/trip.dart';
import 'package:olracddl/screens/trip/trip_screen.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/model_dropdown.dart';
import 'package:uuid/uuid.dart';

enum Page { One, Two }

class StartTripScreen extends StatefulWidget {
  const StartTripScreen();

  @override
  _StartTripScreenState createState() => _StartTripScreenState();
}

class _StartTripScreenState extends State<StartTripScreen> {
  DateTime startDatetime = DateTime.now();

  Port _port;
  Vessel _vessel;
  String _skipperName;
  List<String> _crewMembers = const [];
  String _notes;
  Page _page = Page.One;

  bool _allValid() {
    if(_port == null) {
      return false;
    }

    if(_vessel == null) {
      return false;
    }
    return true;
  }
  Future<void> _onPressSave() async {
    final Position p = await Geolocator().getCurrentPosition();

    final int tripID = await TripRepo().store(Trip(
      uuid: Uuid().v4(),
      startLocation: Location(latitude: p.latitude, longitude: p.longitude),
      startedAt: startDatetime,
      port: _port,
      vessel: _vessel,
      notes: _notes,
      crewMembers: _crewMembers,
      skipperName: _skipperName,
    ));

    await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => TripScreen(tripID)));
  }

  Widget _fishingMethodButton() {
    Future<FishingMethod> _getFM() async {
      return CurrentFishingMethod.get();
    }
    return FutureBuilder(
      future:_getFM(),
      builder: (_, AsyncSnapshot<FishingMethod> snapshot) {
        return StripButton(
          labelText: snapshot.hasData ? snapshot.data.name : '',
          onPressed: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Widget _page1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _fishingMethodButton(),
          _departureDetails(),
          _operational(),
          const SizedBox(height: 15),
          Container(
            constraints: const BoxConstraints.expand(height: 38),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  '1/2',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Positioned(child: _nextButton(), right: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconButton _nextButton() {
    return IconButton(
      //color: _allValid() ? Theme.of(context).accentColor : Colors.grey,
        icon: _allValid()
            ? Image.asset('assets/images/arrow_highlighterBlue.png')
            : Image.asset('assets/images/arrow_grey.png'),
        onPressed: () {
          setState(() {
            _page = Page.Two;
          });
        }
    );
  }

  Widget _departureDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Departure Details', style: Theme.of(context).textTheme.headline2),
        Text('Date, Time and Location', style: Theme.of(context).textTheme.headline3),
        TextField(),
        DDLModelDropdown<Port>(
          labelTheme: false,
          selected: _port,
          label: 'Departure Port',
          onChanged: (Port port) => setState(() => _port = port),
          items: [Port(id: 1, name: 'TODO', createdAt: DateTime.now())].map(
            (Port p) {
              return DropdownMenuItem<Port>(value: p, child: Text(p.name));
            },
          ).toList(),
        ),
      ],
    );
  }

  Widget _operational() {
    final vessels = <Vessel>[
      Vessel(name: 'Pier Pressure', vesselID: '6702345809654', createdAt: DateTime.now(), id: 1),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text('Operational', style: Theme.of(context).textTheme.headline2),
        DDLModelDropdown<Vessel>(
          labelTheme: false,
          selected: _vessel,
          label: 'Vessel',
          onChanged: (Vessel vessel) => setState(() => _vessel = vessel),
          items: vessels.map(
            (Vessel v) {
              return DropdownMenuItem<Vessel>(
                value: v,
                child: Text(v.name),
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  Widget _page2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Crew Members', style: Theme.of(context).textTheme.headline2),
          _skipperNameInput(),
          _crew(),
          _notesInput(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              StripButton(
                labelText: 'Save',
                onPressed: _onPressSave,
                color: OlracColoursLight.olspsHighlightBlue,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _skipperNameInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Skipper', style: Theme.of(context).textTheme.headline3),
          const SizedBox(height: 15),
          TextField(
            onChanged: (String name) => setState(() => _skipperName = name),
            keyboardType: TextInputType.text,
          )
        ],
      ),
    );
  }

  Widget _crew() {
    final title = Row(
      children: [
        Text('Crew', style: Theme.of(context).textTheme.headline3),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              _crewMembers.add('');
            });
          },
        ),
      ],
    );

    final textInputs = Column(
      children: _crewMembers.map(
        (String crewMember) {
          return Padding(
            child: TextField(),
            padding: EdgeInsets.symmetric(vertical: 3),
          );
        },
      ).toList(),
    );
    return Column(
      children: [
        title,
        textInputs,
      ],
    );
  }

  Widget _notesInput() {
    final title = Row(
      children: [
        Text('Notes', style: Theme.of(context).textTheme.headline3),
        IconButton(icon: Icon(Icons.camera_alt)),
      ],
    );
    final input = TextField(minLines: 2, maxLines: 4);
    return Column(
      children: [
        title,
        input,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WestlakeScaffold(
      leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            if (_page == Page.One) {
              Navigator.pop(context);
            } else {
              setState(() {
                _page = Page.One;
              });
            }
          }),
      title: 'Trip Information',
      body: _page == Page.One ? _page1() : _page2(),
    );
  }
}
