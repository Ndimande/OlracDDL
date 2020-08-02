import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/localization/app_localization.dart';
import 'package:olracddl/models/catch_condition.dart';
import 'package:olracddl/models/disposal.dart';
import 'package:olracddl/models/species.dart';
import 'package:olracddl/repos/catch_condition.dart';
import 'package:olracddl/repos/disposal.dart';
import 'package:olracddl/repos/species.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/inputs/datetime_editor.dart';
import 'package:olracddl/widgets/inputs/model_dropdown.dart';

class AddDisposalScreen extends StatefulWidget {
  final int fishingSetID;

  const AddDisposalScreen(this.fishingSetID);

  @override
  _AddDisposalScreenState createState() => _AddDisposalScreenState();
}

class _AddDisposalScreenState extends State<AddDisposalScreen> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime _createdAt = DateTime.now();
  Species _species;
  CatchCondition _disposalState;
  String _estimatedGreenWeight;
  String _numberOfIndividuals;
  Location _location;

  @override
  void initState() {
    super.initState();
    Geolocator().getCurrentPosition().then((Position p) {
      setState(() {
        _location = Location(latitude: p.latitude, longitude: p.longitude);
      });
    });
  }

  bool _allValid() {
    if (_species == null) {
      return false;
    }

    if (_createdAt == null) {
      return false;
    }

    if (_disposalState == null) {
      return false;
    }

    if (_estimatedGreenWeight == null) {
      return false;
    }

    if (_numberOfIndividuals == null) {
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
          Row(
            children: <Widget>[
              Flexible(
                flex: 5,
                child: DateTimeEditor(
                  titleStyle: Theme.of(context).textTheme.headline2,
                  initialDateTime: _createdAt,
                  title: AppLocalizations.of(context).getTranslatedValue('date_time_and_location'),
                  onChanged: (picker, indices) {
                    setState(() {
                      _createdAt = DateTime.parse(picker.adapter.toString());
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

  Widget _disposalStateDropdown() {
    return FutureBuilder(
      future: CatchConditionRepo().all(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        return DDLModelDropdown<CatchCondition>(
          labelTheme: true,
          selected: _disposalState,
          label: AppLocalizations.of(context).getTranslatedValue('disposal_state'),
          onChanged: (CatchCondition disposalState) => setState(() => _disposalState = disposalState),
          items: snapshot.data.map<DropdownMenuItem<CatchCondition>>((CatchCondition disposalState) {
            return DropdownMenuItem<CatchCondition>(value: disposalState, child: Text(disposalState.name, style: Theme.of(context).textTheme.headline3,));
          }).toList(),
        );
      },
    );
  }

  Widget _estimatedGreenWeightsInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context).getTranslatedValue('estimated_green_weight'), style: Theme.of(context).textTheme.headline2),
        const SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 100,
              child: TextField(
                onChanged: (String text) => setState(() => _estimatedGreenWeight = text),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 10),
            Text('Kg', style: Theme.of(context).textTheme.headline2.copyWith(fontWeight: FontWeight.normal))
          ],
        )
      ],
    );
  }

  Widget _numberOfIndividualInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context).getTranslatedValue('number_of_individuals'), style: Theme.of(context).textTheme.headline2),
        const SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 100,
              child: TextField(
                onChanged: (String text) => setState(() => _numberOfIndividuals = text),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 10),
            Text(AppLocalizations.of(context).getTranslatedValue('individuals'), style: Theme.of(context).textTheme.headline2.copyWith(fontWeight: FontWeight.normal))
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
              _speciesDropdown(),
              _disposalStateDropdown(),
              const SizedBox(height: 10),
              _estimatedGreenWeightsInput(),
              const SizedBox(height: 10),
              _numberOfIndividualInput(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _saveButton(),
                ],
              ),
            ],
          )),
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

    final disposal = Disposal(
      location: _location,
      species: _species,
      individuals: int.parse(_numberOfIndividuals),
      fishingSetID: widget.fishingSetID,
      createdAt: _createdAt,
      disposalState: _disposalState,
      estimatedGreenWeight: int.parse(_estimatedGreenWeight) * 1000,
      estimatedGreenWeightUnit: WeightUnit.GRAMS,
    );

    await DisposalRepo().store(disposal);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WestlakeScaffold(
      leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 30,),
            onPressed: () => Navigator.pop(context),
          ),
      title: AppLocalizations.of(context).getTranslatedValue('disposals'),
      scaffoldKey: _scaffoldKey,
      body: _body(),
    );
  }
}

