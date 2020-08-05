import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:olrac_utils/olrac_utils.dart';

import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/localization/app_localization.dart';
import 'package:olracddl/models/catch_condition.dart';
import 'package:olracddl/models/marine_life.dart';
import 'package:olracddl/models/species.dart';
import 'package:olracddl/repos/catch_condition.dart';
import 'package:olracddl/repos/marine_life.dart';
import 'package:olracddl/repos/species.dart';
import 'package:olracddl/widgets/inputs/datetime_editor.dart';
import 'package:olracddl/widgets/inputs/location_editor.dart';
import 'package:olracddl/widgets/inputs/model_dropdown.dart';

import '../../theme.dart';

class AddMarineLifeScreen extends StatefulWidget {
  final int fishingSetID;

  const AddMarineLifeScreen(this.fishingSetID);

  @override
  _AddMarineLifeScreenState createState() => _AddMarineLifeScreenState();
}

class _AddMarineLifeScreenState extends State<AddMarineLifeScreen> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime _createdAt = DateTime.now();
  Species _species;
  CatchCondition _condition;
  String _estimatedWeight;
  String _tagNumber;
  Location _location;

  @override
  void initState() {
    super.initState();
    getLocation().then((Location l) {
      setState(() {
        _location = l;
      });
    });
  }

  Future<Location> getLocation() async {
    final Position p = await Geolocator().getCurrentPosition();
    return Location(latitude: p.latitude, longitude: p.longitude);
  }

  bool _allValid() {
    if (_species == null) {
      return false;
    }

    if (_createdAt == null) {
      return false;
    }

    if (_condition == null) {
      return false;
    }

    if (_estimatedWeight == null) {
      return false;
    }

    if (_tagNumber == null) {
      return false;
    }

    if (_location == null) {
      return false;
    }

    return true;
  }

  Widget _dateTimeInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DateTimeEditor(
            titleStyle: Theme.of(context).textTheme.headline2,
            initialDateTime: _createdAt,
            title: AppLocalizations.of(context)
                .getTranslatedValue('date_time_and_location'),
            onChanged: (picker, indices) {
              setState(() {
                _createdAt = DateTime.parse(picker.adapter.toString());
              });
            },
          ),
          LocationEditor(
            layoutOption: false,
            subTitleStyle: Theme.of(context).textTheme.headline6,
            fieldColor: Colors.white,
            //title: AppLocalizations.of(context).getTranslatedValue('location'),
            titleStyle: Theme.of(context).textTheme.headline3,
            location: _location ?? Location(latitude: 0, longitude: 0),
            onChanged: (Location l) => setState(() => _location = l),
          ),
        ],
      ),
    );
  }

  Widget _speciesDropdown() {
    final _screenWidth = MediaQuery.of(context).size.width; 
    Future<List<Species>> _getSpecies() async => await SpeciesRepo().all();

    return FutureBuilder(
      future: _getSpecies(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        return Container(
          width: _screenWidth * 0.415,
          child: DDLModelDropdown<Species>(
            labelTheme: true,
            selected: _species,
            label:
                AppLocalizations.of(context).getTranslatedValue('marine_species'),
            onChanged: (Species species) => setState(() => _species = species),
            items:
                snapshot.data.map<DropdownMenuItem<Species>>((Species species) {
              return DropdownMenuItem<Species>(
                  value: species,
                  child: Text(
                    species.commonName,
                    style: Theme.of(context).textTheme.headline3,
                  ));
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _conditionDropdown() {
     final _screenWidth = MediaQuery.of(context).size.width; 
    return FutureBuilder(
      future: CatchConditionRepo().all(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        return Container(
          width: _screenWidth * 0.415,
          child: DDLModelDropdown<CatchCondition>(
            labelTheme: true,
            selected: _condition,
            label: AppLocalizations.of(context).getTranslatedValue('condition'),
            onChanged: (CatchCondition condition) =>
                setState(() => _condition = condition),
            items: snapshot.data.map<DropdownMenuItem<CatchCondition>>(
                (CatchCondition condition) {
              return DropdownMenuItem<CatchCondition>(
                  value: condition,
                  child: Text(
                    condition.name,
                    style: Theme.of(context).textTheme.headline3,
                  ));
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _estimatedWeightsInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            '${AppLocalizations.of(context).getTranslatedValue('estimated_weight')} (Kg)',
            style: Theme.of(context).textTheme.headline2),
        const SizedBox(height: 15),
        Container(
          width: 150,
          child: TextField(
            onChanged: (String text) => setState(() => _estimatedWeight = text),
            keyboardType: TextInputType.number,
          ),
        )
      ],
    );
  }

  Widget _tagNumberInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context).getTranslatedValue('tag_number'),
            style: Theme.of(context).textTheme.headline2),
        const SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 150,
              child: TextField(
                onChanged: (String text) => setState(() => _tagNumber = text),
                keyboardType: TextInputType.text,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _dateTimeInput(),
              Row(
                children: [
                  _speciesDropdown(),
                  const SizedBox(width: 15),
                  _conditionDropdown(),
                ],
              ),
              const SizedBox(height: 20),
              _estimatedWeightsInput(),
              const SizedBox(height: 10),
              
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _tagNumberInput(),
                  _saveButton(),
                ],
              ),
            ],
          )),
    );
  }

  StripButton _saveButton() {
    return StripButton(
      color: _allValid()
          ? Theme.of(context).accentColor
          : OlracColoursLight.olspsGrey,
      labelText: AppLocalizations.of(context).getTranslatedValue('save'),
      onPressed: _onPressSaveButton,
    );
  }

  Future<void> _onPressSaveButton() async {
    if (!_allValid()) {
      return;
    }

    final marineLife = MarineLife(
      location: _location,
      species: _species,
      tagNumber: _tagNumber,
      fishingSetID: widget.fishingSetID,
      createdAt: _createdAt,
      condition: _condition,
      estimatedWeight: int.parse(_estimatedWeight) * 1000,
      estimatedWeightUnit: WeightUnit.GRAMS,
    );

    await MarineLifeRepo().store(marineLife);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WestlakeScaffold(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          size: 30,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: AppLocalizations.of(context).getTranslatedValue('marine_life'),
      scaffoldKey: _scaffoldKey,
      body: _body(),
    );
  }
}
