//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:database_repo/database_repo.dart';
import 'package:olrac_utils/units.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/models/current_fishing_method.dart';
import 'package:olracddl/models/fishing_method.dart';
import 'package:olracddl/models/fishing_set.dart';
import 'package:olracddl/models/sea_bottom_type.dart';
import 'package:olracddl/models/species.dart';
import 'package:olracddl/models/cloud_cover.dart';
import 'package:olracddl/models/cloud_type.dart';
import 'package:olracddl/models/sea_condition.dart';
import 'package:olracddl/models/moon_phase.dart';
import 'package:olracddl/repos/fishing_set.dart';
import 'package:olracddl/repos/sea_bottom_type.dart';
import 'package:olracddl/repos/species.dart';
import 'package:olracddl/repos/sea_condition.dart';
import 'package:olracddl/repos/moon_phase.dart';
import 'package:olracddl/repos/cloud_cover.dart';
import 'package:olracddl/repos/cloud_type.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/datetime_editor.dart';
import 'package:olracddl/widgets/environment_dialog.dart';
import 'package:olracddl/widgets/model_dropdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/weather_condition_button.dart';

enum Page {
  One,
  Two,
}

class StartSetScreen extends StatefulWidget {
  final int _tripID;
  const StartSetScreen(this._tripID);
  @override
  _StartSetScreenState createState() => _StartSetScreenState();
}

class _StartSetScreenState extends State<StartSetScreen> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  /// When the set started
  DateTime _startedAt = DateTime.now();

  String _fishingArea;

  /// Sea bottom depth and unit
  String _seaBottomDepth; //************ needs to be changed

  String _minimumHookSize;

  Page _page = Page.One;

  SeaBottomType _seaBottomType;

  Species _targetSpecies;

  String _notes;

  SeaCondition _seaCondition;

  CloudCover _cloudCover;

  CloudType _cloudType;

  MoonPhase _moonPhase;

  bool _page1Valid() {
    if (_fishingArea == null) {
      return false;
    }

    if (_seaBottomDepth == null) {
      return false;
    }

    if (_seaBottomType == null) {
      return false;
    }

    if (_minimumHookSize == null) {
      return false;
    }

    if (_startedAt == null) {
      return false;
    }

    return true;
  }

  bool _page2Valid() {
    if (_targetSpecies == null) {
      return false;
    }

    return true;
  }

  Future<void> _onPressSaveButton() async {
    final Position p = await Geolocator().getCurrentPosition();
    final Location location = Location(longitude: p.longitude, latitude: p.latitude);

    final FishingMethod currentFishingMethod = await CurrentFishingMethod.get();
    assert(currentFishingMethod != null);
    final FishingSet fishingSet = FishingSet(
      startedAt: _startedAt,
      startLocation: location,
      fishingMethod: currentFishingMethod,
      notes: _notes,
      minimumHookSize: _minimumHookSize,
      tripId: widget._tripID,
      cloudCover: _cloudCover,
      cloudType: _cloudType,
      seaBottomDepth: int.parse(_seaBottomDepth),
      seaBottomType: _seaBottomType,
      seaBottomDepthUnit: LengthUnit.METERS,
      seaCondition: _seaCondition,
      moonPhase: _moonPhase,
      targetSpecies: _targetSpecies,
    );

    await FishingSetRepo().store(fishingSet);

    Navigator.pop(context);
  }

  Widget _dateTimeInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              Flexible(
                flex: 5,
                child: DateTimeEditor(
                  titleStyle: Theme.of(context).textTheme.headline2,
                  initialDateTime: DateTime.now(),
                  title: 'Date, Time and Location',
                  onChanged: (picker, indices) {
                    setState(() {
                      _startedAt = DateTime.parse(picker.adapter.toString());
                    });
                  },
                ),
              ),
              const SizedBox(width: 5),
              Flexible(
                flex: 1,
                child: IconButton(
                  icon: Image.asset('assets/images/location_icon.png'),
                  onPressed: () {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _fishingAreaInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Fishing Area (Statistical Rectangle)',
              style: Theme.of(context).textTheme.headline3),
          const SizedBox(height: 15),
          TextField(
            onChanged: (String name) => setState(() => _fishingArea = name),
            keyboardType: TextInputType.text,
          )
        ],
      ),
    );
  }

  Widget _seaBottomDepthInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sea Bottom Depth (m)', style: Theme.of(context).textTheme.headline3),
          const SizedBox(height: 15),
          TextField(
            onChanged: (String name) => setState(() => _seaBottomDepth = name),
            keyboardType: TextInputType.number,
          )
        ],
      ),
    );
  }

  Widget _seaBottomTypeDropdown() {
    Future<List<SeaBottomType>> _getSeaBottomType() async => await SeaBottomTypeRepo().all();

    return FutureBuilder(
      future: _getSeaBottomType(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        return DDLModelDropdown<SeaBottomType>(
          labelTheme: false,
          selected: _seaBottomType,
          label: 'Sea Bottom Type',
          onChanged: (SeaBottomType seaBottomType) =>
              setState(() => _seaBottomType = seaBottomType),
          items: snapshot.data.map<DropdownMenuItem<SeaBottomType>>((SeaBottomType sbt) {
            return DropdownMenuItem<SeaBottomType>(value: sbt, child: Text(sbt.name));
          }).toList(),
        );
      },
    );
  }

  Widget _targetSpeciesDropdown() {
    Future<List<Species>> _getSpecies() async => await SpeciesRepo().all();

    return FutureBuilder(
      future: _getSpecies(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        return DDLModelDropdown<Species>(
          labelTheme: true,
          selected: _targetSpecies,
          label: 'Target Species',
          onChanged: (Species species) => setState(() => _targetSpecies = species),
          items: snapshot.data.map<DropdownMenuItem<Species>>((Species species) {
            return DropdownMenuItem<Species>(value: species, child: Text(species.commonName));
          }).toList(),
        );
      },
    );
  }

  Widget _minimumHookSizeInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Minimum Hook Size', style: Theme.of(context).textTheme.headline3),
          const SizedBox(height: 15),
          TextField(
            onChanged: (String minimumHookSize) =>
                setState(() => _minimumHookSize = minimumHookSize),
            keyboardType: TextInputType.text,
          )
        ],
      ),
    );
  }

  Widget _notesInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Notes', style: Theme.of(context).textTheme.headline2),
        const SizedBox(height: 15),
        TextField(
          onChanged: (String text ) => setState(()=> _notes),
        ),
      ],
    );
  }

  Widget _page1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _dateTimeInput(),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Operational',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          const SizedBox(height: 15),
          _fishingAreaInput(),
          _seaBottomDepthInput(),
          _seaBottomTypeDropdown(),
          _minimumHookSizeInput(),
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

  Widget _page2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _targetSpeciesDropdown(),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Weather Conditions',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          const SizedBox(height: 15),
          _weatherConditions(),
          //WeatherConditionButton(),
          const SizedBox(height: 15),
          _notesInput(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [_saveButton()],
          ),
        ],
      ),
    );
  }

  Widget _weatherConditions() {
    return Container(
      height: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _weatherConditionButton(
                  _onSeaConditionPressed,
                  'Sea Condition',
                  'assets/icons/svg/wave.svg',
                  RoundedCorner.topLeft,
                ),
                _weatherConditionButton(
                  _onCloudTypePressed,
                  'Cloud Type',
                  'assets/icons/svg/cloud.svg',
                  RoundedCorner.topRight,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _weatherConditionButton(
                  _onCloudCoverPressed,
                  'Cloud Cover',
                  'assets/icons/svg/cloud_sun.svg',
                  RoundedCorner.bottomLeft,
                ),
                _weatherConditionButton(
                  _onMoonPhasePressed,
                  'Moon Phase',
                  'assets/icons/svg/moon.svg',
                  RoundedCorner.bottomRight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _weatherConditionButton(
    Function onTap,
    String label,
    String svgPath,
    RoundedCorner roundedCorner,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(7, 3, 7, 7),
          margin: const EdgeInsets.all(0.5),
          decoration: BoxDecoration(
            border: Border.all(
              width: 3,
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.only(
              topLeft:
                  roundedCorner == RoundedCorner.topLeft ? const Radius.circular(15) : Radius.zero,
              topRight:
                  roundedCorner == RoundedCorner.topRight ? const Radius.circular(15) : Radius.zero,
              bottomLeft: roundedCorner == RoundedCorner.bottomLeft
                  ? const Radius.circular(15)
                  : Radius.zero,
              bottomRight: roundedCorner == RoundedCorner.bottomRight
                  ? const Radius.circular(15)
                  : Radius.zero,
            ),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              const SizedBox(height: 4),
              Expanded(child: SvgPicture.asset(svgPath)),
            ],
          ),
        ),
      ),
    );
  }

  Future<Model> _seaConditionInputDialog() async {
    final List<SeaCondition> _seaConditions = await SeaConditionRepo().all();
    return await showDialog<Model>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return EnvironmentDialog(
          title: 'Sea Condition',
          models: _seaConditions,
        );
      },
    );
  }

  Future<void> _onSeaConditionPressed() async {
    _seaCondition = await _seaConditionInputDialog();
  }

  Future<Model> _cloudTypeInputDialog() async {
    final List<CloudType> _cloudTypes = await CloudTypeRepo().all();
    return await showDialog<Model>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return EnvironmentDialog(
          title: 'Cloud Type',
          models: _cloudTypes,
        );
      },
    );
  }

  Future<void> _onCloudTypePressed() async {
    _cloudType = await _cloudTypeInputDialog();
  }

  Future<Model> _cloudCoverInputDialog() async {
    final List<CloudCover> _cloudCover = await CloudCoverRepo().all();
    return await showDialog<Model>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return EnvironmentDialog(
          title: 'Cloud Type',
          models: _cloudCover,
        );
      },
    );
  }

  Future<void> _onCloudCoverPressed() async {
    _cloudCover = await _cloudCoverInputDialog();
  }

  Future<Model> _moonPhaseInputDialog() async {
    final List<MoonPhase> _moonPhase = await MoonPhaseRepo().all();
    return await showDialog<Model>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return EnvironmentDialog(
          title: 'Cloud Type',
          models: _moonPhase,
        );
      },
    );
  }

  Future<void> _onMoonPhasePressed() async {
    _moonPhase = await _moonPhaseInputDialog();
  }

  IconButton _nextButton() {
    return IconButton(
        icon: _page1Valid()
            ? Image.asset('assets/images/arrow_highlighterBlue.png')
            : Image.asset('assets/images/arrow_grey.png'),
        onPressed: () {
          setState(() {
            _page = Page.Two;
          });
        });
  }

  StripButton _saveButton() {
    return StripButton(
      color: _page2Valid() ? Theme.of(context).accentColor : OlracColoursLight.olspsGrey,
      onPressed: _page2Valid() ? _onPressSaveButton : () {},
      labelText: 'Save',
    );
  }

  @override
  Widget build(BuildContext context) {
    return WestlakeScaffold(
      scaffoldKey: _scaffoldKey,
      title: 'Start Fishing Set',
      body: _page == Page.One ? _page1() : _page2(),
    );
  }
}

enum RoundedCorner { topLeft, topRight, bottomLeft, bottomRight }
