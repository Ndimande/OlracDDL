import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olrac_widgets/olrac_widgets.dart';

import '../home.dart';

class AddMarineLifeScreen extends StatefulWidget {
  @override
  _AddMarineLifeScreenState createState() => _AddMarineLifeScreenState();
}

class _AddMarineLifeScreenState extends State<AddMarineLifeScreen> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  int _numberOfIndividuals;
  String _date;
  String _species;
  String _condition;

  //LengthUnit _estimatedGreenWeight;
  String _estimatedGreenWeight;
  String _tagNumber;

  bool _allValid() {
    if (_species == null) {
      return false;
    } else {
      return true;
    }
  }

  Widget _dateInput() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Date, Time and Location', style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: 15),
          Row(
            children: <Widget>[
              Flexible(
                flex: 5,
                child: TextField(
                    //onChanged: (String name) => setState(() => _name = name),
                    //keyboardType: TextInputType.text,
                    ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                height: 40,
                width: 40,
                child: SvgPicture.asset(
                  'assets/icons/image/location_icon.svg',
                ),
                padding: const EdgeInsets.all(1.0),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _speciesInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Species', style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: 15),
          Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.left,
                  //Dropdown
                  decoration: InputDecoration(
                    labelText: 'Tap to Select',
                    // contentPadding: EdgeInsets.all(8),  // Added this
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _conditionInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Condition', style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: 15),
          Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.left,
                  //Dropdown
                  decoration: InputDecoration(
                    labelText: 'Tap to Select',
                    // contentPadding: EdgeInsets.all(8),  // Added this
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _estimatedWeightsInput() {
    return Container(
      width: 150,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Estimated Weight', style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: 15),
          TextField(
            onChanged: (String name) => setState(() => _estimatedGreenWeight = (name)),
            keyboardType: TextInputType.text,
          )
        ],
      ),
    );
  }

  Widget _tagNumberInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tag Number', style: Theme.of(context).textTheme.headline2),
          //  const SizedBox(height: 15),
          Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.left,
                  //Dropdown
                  decoration: InputDecoration(
                    labelText: 'Tap to Select',
                    // contentPadding: EdgeInsets.all(8),  // Added this
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _body() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Stack(
        children: [
          Container(
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _dateInput(),
                  _speciesInput(),
                  _conditionInput(),
                  _estimatedWeightsInput(),
                  _tagNumberInput(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _saveButton(),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WestlakeScaffold(
      scaffoldKey: _scaffoldKey,
      body: _body(),
      actions: [
        Expanded(
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            BackButton(),
            Text(
              '      Marine Life',
              style: Theme.of(context).textTheme.headline1,
            ),
          ]),
        )
      ],
    );
  }

  StripButton _saveButton() {
    return StripButton(
      color: _allValid() ? Theme.of(context).accentColor : Colors.lightBlue,
      labelText: 'Save',
      onPressed: () => _onPressSaveButton,
    );
  }

  Future<void> _onPressSaveButton() async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }
}