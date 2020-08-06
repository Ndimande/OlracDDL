import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olrac_utils/units.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/localization/app_localization.dart';
import 'package:olracddl/models/retained_catch.dart';
import 'package:olracddl/models/species.dart';
import 'package:olracddl/repos/retained_catch.dart';
import 'package:olracddl/repos/species.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/inputs/model_dropdown.dart';

class AddRetainedScreen extends StatefulWidget {
  final int fishingSetID;

  const AddRetainedScreen(this.fishingSetID);

  @override
  _AddRetainedScreenState createState() => _AddRetainedScreenState();
}

class _AddRetainedScreenState extends State<AddRetainedScreen> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  int _numberOfIndividuals;
  int _greenWeight;
  Species _species;

  bool _allValid() {
    if (_greenWeight == null) {
      return false;
    }
    if (_numberOfIndividuals == null) {
      return false;
    }

    if (_species == null) {
      return false;
    }

    return true;
  }

  Widget _speciesDropdown() {
    Future<List<Species>> _getSpecies() async => await SpeciesRepo().all();

    return FutureBuilder(
      future: _getSpecies(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        return DDLModelDropdown<Species>(
          labelTheme: true,
          selected: _species,
          label: AppLocalizations.of(context).getTranslatedValue('species'),
          onChanged: (Species species) => setState(() => _species = species),
          items: snapshot.data.map<DropdownMenuItem<Species>>((Species species) {
            return DropdownMenuItem<Species>(value: species, child: Text(species.commonName, style: Theme.of(context).textTheme.headline3,));
          }).toList(),
        );
      },
    );
  }

  Widget _greenWeightsInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${AppLocalizations.of(context).getTranslatedValue('green_weight')} (Kg)', style: Theme.of(context).textTheme.headline2),
        const SizedBox(height: 15),
        Container(
          width: 110,
          child: TextField(
            onChanged: (String greenWeight) =>
                setState(() => _greenWeight = (double.parse(greenWeight) * 1000).toInt()),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _numberOfIndividualsInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context).getTranslatedValue('number_of_individuals'), style: Theme.of(context).textTheme.headline2),
        const SizedBox(height: 15),
        Container(
          width: 110,
          child: TextField(
            onChanged: (String numberOfIndividuals) =>
                setState(() => _numberOfIndividuals = int.parse(numberOfIndividuals)),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _speciesDropdown(),
          const SizedBox(height: 15),
          _greenWeightsInput(),
          const SizedBox(height: 15),
          _numberOfIndividualsInput(),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [_saveButton()]),
        ],
      ),
    );
  }

  StripButton _saveButton() {
    return StripButton(
      color: _allValid() ? Theme.of(context).accentColor : OlracColoursLight.olspsGrey,
      labelText: AppLocalizations.of(context).getTranslatedValue('save'),
      onPressed: _onPressSaveButton,
    );
  }

  Future<void> _onPressSaveButton() async {
    if (!_allValid()) {
      return;
    }

    final Position p = await Geolocator().getCurrentPosition();
    final Location location = Location(latitude: p.latitude, longitude: p.longitude);

    final RetainedCatch retainedCatch = RetainedCatch(
      species: _species,
      greenWeight: _greenWeight,
      fishingSetID: widget.fishingSetID,
      greenWeightUnit: WeightUnit.GRAMS,
      individuals: _numberOfIndividuals,
      location: location,
    );

    await RetainedCatchRepo().store(retainedCatch);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WestlakeScaffold(
      leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 30,),
            onPressed: () => Navigator.pop(context),
          ),
      scaffoldKey: _scaffoldKey,
      body: _body(),
      title: AppLocalizations.of(context).getTranslatedValue('catch_information'),
    );
  }
}
