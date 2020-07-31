//import 'dart:html';
import 'package:database_repo/database_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olrac_utils/units.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/localization/app_localization.dart';
import 'package:olracddl/models/cloud_cover.dart';
import 'package:olracddl/models/cloud_type.dart';
import 'package:olracddl/models/current_fishing_method.dart';
import 'package:olracddl/models/fishing_area.dart';
import 'package:olracddl/models/fishing_method.dart';
import 'package:olracddl/models/fishing_set.dart';
import 'package:olracddl/models/moon_phase.dart';
import 'package:olracddl/models/sea_bottom_type.dart';
import 'package:olracddl/models/sea_condition.dart';
import 'package:olracddl/models/species.dart';
import 'package:olracddl/repos/cloud_cover.dart';
import 'package:olracddl/repos/cloud_type.dart';
import 'package:olracddl/repos/fishing_area.dart';
import 'package:olracddl/repos/fishing_set.dart';
import 'package:olracddl/repos/moon_phase.dart';
import 'package:olracddl/repos/sea_bottom_type.dart';
import 'package:olracddl/repos/sea_condition.dart';
import 'package:olracddl/repos/species.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/dialogs/environment_dialog.dart';
import 'package:olracddl/widgets/inputs/datetime_editor.dart';
import 'package:olracddl/widgets/inputs/model_dropdown.dart';

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

  FishingArea _fishingArea;

  /// Sea bottom depth and unit
  String _seaBottomDepth;

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
    if (_targetSpecies == null ||
        _seaCondition == null ||
        _cloudType == null ||
        _cloudCover == null ||
        _moonPhase == null) {
      return false;
    }

    return true;
  }

  Future<void> _onPressSaveButton() async {
    final Position p = await Geolocator().getCurrentPosition();
    final Location location =
        Location(longitude: p.longitude, latitude: p.latitude);

    final FishingMethod currentFishingMethod = await CurrentFishingMethod.get();
    assert(currentFishingMethod != null);
    final FishingSet fishingSet = FishingSet(
      startedAt: _startedAt,
      startLocation: location,
      fishingMethod: currentFishingMethod,
      notes: _notes,
      minimumHookSize: _minimumHookSize,
      tripID: widget._tripID,
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

  Widget _fishingAreaDropdown() {
    return FutureBuilder(
      future: FishingAreaRepo().all(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          throw snapshot.error;
        }
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        return DDLModelDropdown<FishingArea>(
          label: AppLocalizations.of(context).getTranslatedValue('fishing_area'),
          items: snapshot.data
              .map<DropdownMenuItem<FishingArea>>((FishingArea fa) {
            return DropdownMenuItem<FishingArea>(
                value: fa, child: Text(fa.name));
          }).toList(),
          onChanged: (FishingArea fa) {
            setState(() {
              _fishingArea = fa;
            });
          },
          selected: _fishingArea,
        );
      },
    );
  }

  Widget _seaBottomDepthInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context).getTranslatedValue('sea_bottom_depth'),
              style: Theme.of(context).textTheme.headline3),
          const SizedBox(height: 15),
          TextField(
            style: Theme.of(context).textTheme.headline3,
            onChanged: (String name) => setState(() => _seaBottomDepth = name),
            keyboardType: TextInputType.number,
          )
        ],
      ),
    );
  }

  Widget _seaBottomTypeDropdown() {
    return FutureBuilder(
      future: SeaBottomTypeRepo().all(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          throw snapshot.error;
        }
        if (!snapshot.hasData) {
          return Container();
        }
        return DDLModelDropdown<SeaBottomType>(
          labelTheme: false,
          selected: _seaBottomType,
          label: AppLocalizations.of(context).getTranslatedValue('sea_bottom_type'),
          onChanged: (SeaBottomType seaBottomType) =>
              setState(() => _seaBottomType = seaBottomType),
          items: snapshot.data
              .map<DropdownMenuItem<SeaBottomType>>((SeaBottomType sbt) {
            return DropdownMenuItem<SeaBottomType>(
                value: sbt, child: Text(sbt.name));
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
          label: AppLocalizations.of(context).getTranslatedValue('target_species'),
          onChanged: (Species species) =>
              setState(() => _targetSpecies = species),
          items:
              snapshot.data.map<DropdownMenuItem<Species>>((Species species) {
            return DropdownMenuItem<Species>(
                value: species, child: Text(species.commonName));
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
          Text(AppLocalizations.of(context).getTranslatedValue('minimum_hook_size'),
              style: Theme.of(context).textTheme.headline3),
          const SizedBox(height: 15),
          TextField(
            style: Theme.of(context).textTheme.headline3,
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
        Text(AppLocalizations.of(context).getTranslatedValue('notes'), style: Theme.of(context).textTheme.headline2),
        const SizedBox(height: 15),
        TextField(
          onChanged: (String text) => setState(() => _notes = text),
        ),
      ],
    );
  }

  Widget _paginator() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
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
              AppLocalizations.of(context).getTranslatedValue('operational'),
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          const SizedBox(height: 15),
          _fishingAreaDropdown(),
          _seaBottomDepthInput(),
          _seaBottomTypeDropdown(),
          _minimumHookSizeInput(),
          const SizedBox(height: 15),
          _paginator(),
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
              AppLocalizations.of(context).getTranslatedValue('weather_conditions'),
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          const SizedBox(height: 15),
          _weatherConditions(),
          const SizedBox(height: 15),
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
                  _seaCondition != null,
                  _onSeaConditionPressed,
                  AppLocalizations.of(context).getTranslatedValue('sea_condition'),
                  'assets/icons/svg/wave.svg',
                  RoundedCorner.topLeft,
                ),
                _weatherConditionButton(
                  _cloudType != null,
                  _onCloudTypePressed,
                  AppLocalizations.of(context).getTranslatedValue('cloud_type'),
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
                  _cloudCover != null,
                  _onCloudCoverPressed,
                  AppLocalizations.of(context).getTranslatedValue('cloud_cover'),
                  'assets/icons/svg/cloud_sun.svg',
                  RoundedCorner.bottomLeft,
                ),
                _weatherConditionButton(
                  _moonPhase != null,
                  _onMoonPhasePressed,
                  AppLocalizations.of(context).getTranslatedValue('moon_phase'),
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
    bool confirmed,
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
              topLeft: roundedCorner == RoundedCorner.topLeft
                  ? const Radius.circular(15)
                  : Radius.zero,
              topRight: roundedCorner == RoundedCorner.topRight
                  ? const Radius.circular(15)
                  : Radius.zero,
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
              Expanded(
                child: confirmed
                    ? SvgPicture.asset(
                        svgPath,
                        color: OlracColoursLight.olspsHighlightBlue,
                      )
                    : SvgPicture.asset(svgPath),
              ),
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
          title: AppLocalizations.of(context).getTranslatedValue('sea_condition'),
          models: _seaConditions,
        );
      },
    );
  }

  Future<void> _onSeaConditionPressed() async {
    _seaCondition = await _seaConditionInputDialog();
    if (_seaCondition != null) {
      setState(() {});
    }
  }

  Future<Model> _cloudTypeInputDialog() async {
    final List<CloudType> _cloudTypes = await CloudTypeRepo().all();
    return await showDialog<Model>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return EnvironmentDialog(
          title: AppLocalizations.of(context).getTranslatedValue('cloud_type'),
          models: _cloudTypes,
        );
      },
    );
  }

  Future<void> _onCloudTypePressed() async {
    _cloudType = await _cloudTypeInputDialog();
    if (_cloudType != null) {
      setState(() {});
    }
  }

  Future<Model> _cloudCoverInputDialog() async {
    final List<CloudCover> _cloudCover = await CloudCoverRepo().all();
    return await showDialog<Model>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return EnvironmentDialog(
          title: AppLocalizations.of(context).getTranslatedValue('cloud_cover'),
          models: _cloudCover,
        );
      },
    );
  }

  Future<void> _onCloudCoverPressed() async {
    _cloudCover = await _cloudCoverInputDialog();
    if (_cloudCover != null) {
      setState(() {});
    }
  }

  Future<Model> _moonPhaseInputDialog() async {
    final List<MoonPhase> _moonPhase = await MoonPhaseRepo().all();
    return await showDialog<Model>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return EnvironmentDialog(
          title: AppLocalizations.of(context).getTranslatedValue('moon_phase'),
          models: _moonPhase,
        );
      },
    );
  }

  Future<void> _onMoonPhasePressed() async {
    _moonPhase = await _moonPhaseInputDialog();
    if (_moonPhase != null) {
      setState(() {});
    }
  }

  IconButton _nextButton() {
    return IconButton(
        icon: _page1Valid()
            ? Image.asset('assets/images/arrow_highlighterBlue.png')
            : Image.asset('assets/images/arrow_grey.png'),
        onPressed: _page1Valid()
            ? () {
                setState(() {
                  _page = Page.Two;
                });
              }
            : () {});
  }

  StripButton _saveButton() {
    return StripButton(
      color: _page2Valid()
          ? Theme.of(context).accentColor
          : OlracColoursLight.olspsGrey,
      onPressed: _page2Valid() ? _onPressSaveButton : () {},
      labelText: AppLocalizations.of(context).getTranslatedValue('save'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WestlakeScaffold(
      scaffoldKey: _scaffoldKey,
      title: AppLocalizations.of(context).getTranslatedValue('start_fishing_set'),
      body: _page == Page.One ? _page1() : _page2(),
    );
  }
}

enum RoundedCorner { topLeft, topRight, bottomLeft, bottomRight }
