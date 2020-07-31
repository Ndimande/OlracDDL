import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/localization/app_localization.dart';
import 'package:olracddl/models/crew_member.dart';
import 'package:olracddl/models/current_fishing_method.dart';
import 'package:olracddl/models/fishing_method.dart';
import 'package:olracddl/models/port.dart';
import 'package:olracddl/models/skipper.dart';
import 'package:olracddl/models/trip.dart';
import 'package:olracddl/models/vessel.dart';
import 'package:olracddl/repos/port.dart';
import 'package:olracddl/repos/skipper.dart';
import 'package:olracddl/repos/trip.dart';
import 'package:olracddl/repos/vessel.dart';
import 'package:olracddl/screens/fishing_method.dart';
import 'package:olracddl/screens/trip.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/dialogs/add_crew_dialogbox.dart';
import 'package:olracddl/widgets/inputs/datetime_editor.dart';
import 'package:olracddl/widgets/inputs/model_dropdown.dart';
import 'package:uuid/uuid.dart';

enum Page { One, Two }

class StartTripScreen extends StatefulWidget {
  const StartTripScreen();

  @override
  _StartTripScreenState createState() =>
      _StartTripScreenState(startDatetime: DateTime.now());
}

class _StartTripScreenState extends State<StartTripScreen> {
  _StartTripScreenState({this.startDatetime});

  DateTime startDatetime;

  Port _port;
  Vessel _vessel;
  Skipper _skipper;
  List<CrewMember> _crewMembers = [];
  String _notes;
  Page _page = Page.One;

  bool _page1Valid() {
    if (_port == null) {
      return false;
    }

    if (_vessel == null) {
      return false;
    }
    return true;
  }

  bool _page2Valid() {
    if (_skipper == null) {
      return false;
    }

    if (_crewMembers.isEmpty) {
      return false;
    }

    return true;
  }

  Future<void> _onPressSave() async {
    if (!_page2Valid()) {
      return;
    }

    final Position p = await Geolocator().getCurrentPosition();

    final newTrip = Trip(
      uuid: Uuid().v4(),
      startLocation: Location(latitude: p.latitude, longitude: p.longitude),
      startedAt: startDatetime,
      port: _port,
      vessel: _vessel,
      notes: _notes,
      crewMembers: _crewMembers,
      skipper: _skipper,
    );

    final int tripID = await TripRepo().store(newTrip);

    await Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => TripScreen(tripID)));
  }

  Widget _fishingMethodButton() {
    Future<FishingMethod> _getFM() async {
      return CurrentFishingMethod.get();
    }

    return FutureBuilder(
      future: _getFM(),
      builder: (_, AsyncSnapshot<FishingMethod> snapshot) {
        return RaisedButton(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          color: OlracColoursLight.olspsDarkBlue,
          child: Text(snapshot.hasData ? snapshot.data.name : '',
              style: Theme.of(context).primaryTextTheme.headline5),
          onPressed: () async {
            final FishingMethod fm = await Navigator.push(context,
                MaterialPageRoute(builder: (_) => FishingMethodScreen()));
            if (fm != null) {
              await CurrentFishingMethod.set(fm);
            }
            setState(() {});
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
          const SizedBox(height: 15),
          _departureDetails(),
          _operational(),
          const SizedBox(height: 20),
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

  Widget _page2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context).getTranslatedValue('crew_members'), style: Theme.of(context).textTheme.headline2),
          _skipperDropdown(),
          _crew(),
          _notesInput(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [_saveButton()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _saveButton() {
    return StripButton(
      labelText: AppLocalizations.of(context).getTranslatedValue('save'),
      onPressed: _onPressSave,
      color: _page2Valid()
          ? OlracColoursLight.olspsHighlightBlue
          : OlracColoursLight.olspsGrey,
    );
  }

  IconButton _nextButton() {
    return IconButton(
        icon: _page1Valid()
            ? Image.asset('assets/images/arrow_highlighterBlue.png')
            : Image.asset('assets/images/arrow_grey.png'),
        onPressed: () {
          setState(() {
            if (_page1Valid()) {
              _page = Page.Two;
            }
          });
        });
  }

  Widget _portDropdown() {
    Future<List<Port>> getPorts() async => await PortRepo().all();

    return FutureBuilder(
      builder: (context, AsyncSnapshot<List<Port>> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        return DDLModelDropdown<Port>(
          labelTheme: false,
          selected: _port,
          label: AppLocalizations.of(context).getTranslatedValue('departure_port'),
          onChanged: (Port port) => setState(() => _port = port),
          items: snapshot.data.map(
            (Port p) {
              return DropdownMenuItem<Port>(value: p, child: Text(p.name));
            },
          ).toList(),
        );
      },
      future: getPorts(),
    );
  }

  Widget _departureDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context).getTranslatedValue('departure_details'), style: Theme.of(context).textTheme.headline2),
        DateTimeEditor(
          title: AppLocalizations.of(context).getTranslatedValue('date_time_and_location'),
          onChanged: (Picker picker, List<int> selectedIndices) {
            setState(() {
              startDatetime = DateTime.parse(picker.adapter.toString());
            });
          },
          initialDateTime: startDatetime,
        ),
        _portDropdown(),
      ],
    );
  }

  Widget _vesselDropdown() {
    Future<List<Vessel>> getVessels() async => await VesselRepo().all();

    return FutureBuilder(
      future: getVessels(),
      builder: (context, AsyncSnapshot<List<Vessel>> snapshot) {
        if (snapshot.hasError) {
          throw snapshot.error;
        }
        if (!snapshot.hasData) {
          return Container();
        }
        return DDLModelDropdown<Vessel>(
          labelTheme: false,
          selected: _vessel,
          label: AppLocalizations.of(context).getTranslatedValue('vessel'),
          onChanged: (Vessel vessel) => setState(() => _vessel = vessel),
          items: snapshot.data.map(
            (Vessel v) {
              return DropdownMenuItem<Vessel>(
                value: v,
                child: Text(v.name),
              );
            },
          ).toList(),
        );
      },
    );
  }

  Widget _skipperDropdown() {
    Future<List<Skipper>> getSkippers() async => await SkipperRepo().all();

    return FutureBuilder(
      future: getSkippers(),
      builder: (context, AsyncSnapshot<List<Skipper>> snapshot) {
        if (snapshot.hasError) {
          throw snapshot.error;
        }
        if (!snapshot.hasData) {
          return Container();
        }
        return DDLModelDropdown<Skipper>(
          labelTheme: false,
          selected: _skipper,
          label: AppLocalizations.of(context).getTranslatedValue('skipper'),
          onChanged: (Skipper skipper) => setState(() => _skipper = skipper),
          items: snapshot.data.map(
            (Skipper v) {
              return DropdownMenuItem<Skipper>(
                value: v,
                child: Text(v.name),
              );
            },
          ).toList(),
        );
      },
    );
  }

  Widget _operational() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(AppLocalizations.of(context).getTranslatedValue('operational'), style: Theme.of(context).textTheme.headline2),
        _vesselDropdown(),
      ],
    );
  }

  Widget _columnHeader(int flex, String header) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Text(
          header,
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
    );
  }

  Widget _rowLayout(int flex, String info) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Text(
          info,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }

  Widget _crewMemberRow(
    int index,
    String shortName,
    String seamanId,
    int mainRole,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _rowLayout(1, index.toString()),
        _rowLayout(3, shortName),
        _rowLayout(3, seamanId),
        _rowLayout(2, mainRole.toString()),
      ],
    );
  }

  Widget _noCrewMembersAdded() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      child: Text(
        AppLocalizations.of(context).getTranslatedValue('no_crew_members_added'),
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  Widget _crewList() {
    int index = 0; 
    return Column(
      children: _crewMembers.map((CrewMember cm) {
        index ++; 
        return _crewMemberRow(index, cm.shortName, cm.seamanId, 2); //role needs to be changed here from being static 
      }).toList(),
    );
  }

  Widget _crew() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15,),
      child: Column(
        children: [
          Row(
            children: [
              Text(AppLocalizations.of(context).getTranslatedValue('crew'), style: Theme.of(context).textTheme.headline3),
              GestureDetector(
                onTap: () async {
                  final List<CrewMember> crewMembers =
                      await showDialog<List<CrewMember>>(
                    builder: (_) => AddCrewDialog(),
                    context: context,
                  );
                  if (crewMembers != null) {
                    setState(() {
                      _crewMembers = crewMembers;
                    });
                  }
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: SvgPicture.asset('assets/icons/image/add_icon.svg',
                      height: 20, width: 20),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _columnHeader(1, '#'),
                _columnHeader(3, AppLocalizations.of(context).getTranslatedValue('name')),
                _columnHeader(3, AppLocalizations.of(context).getTranslatedValue('seaman_id')),
                _columnHeader(2, 'Role'),
              ],
            ),
          ),
          Container(
            child: _crewMembers.isEmpty ? _noCrewMembersAdded() : _crewList(),
          ),
        ],
      ),
    );
  }

  Widget _notesInput() {
    final title = Row(
      children: [
        Text(AppLocalizations.of(context).getTranslatedValue('notes'), style: Theme.of(context).textTheme.headline3),
        IconButton(
          icon: const Icon(Icons.camera_alt),
          onPressed: () {},
        ),
      ],
    );

    return Column(
      children: [
        title,
        TextField(
          onChanged: (String text) => _notes = text,
          minLines: 2,
          maxLines: 4,
          style: Theme.of(context).textTheme.headline3,
        ),
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
      title: AppLocalizations.of(context).getTranslatedValue('trip_information'),
      body: _page == Page.One ? _page1() : _page2(),
    );
  }
}
