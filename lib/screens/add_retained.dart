//import 'dart:html';
import 'package:flutter_svg/svg.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:flutter/material.dart';
import 'package:olrac_utils/units.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import '../widgets/weather_condition_button.dart';
import 'home/home.dart';

class AddRetainedScreen extends StatefulWidget {
  @override
  _AddRetainedScreenState createState() => _AddRetainedScreenState();
}

class _AddRetainedScreenState extends State<AddRetainedScreen> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  String _numberOfIndividuals;
  String _greenWeights;
  LengthUnit _seaBottomDepthUnit;

  bool _allValid() {
    if (_greenWeights == null) {
      return false;
    } else {
      return true;
    }
  }

  Widget _speciesInput() {
    return Container(
      height: 150,
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

  Widget _greenWeightsInput() {
    return Container(
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Green Weight', style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: 15),

          Row(children: [
            Container(
                  width: 110,
                  child: TextField(
                    onChanged: (String name) => setState(() => _greenWeights = name),
                    keyboardType: TextInputType.text,
                  ),
                ),
                const Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Text('Kg'),
                ),
              ],
            ),

        ],
      ),
    );
  }

  Widget _numberOfIndividualInput() {
    return Container(
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Number of Individuals', style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: 15),

          Row(children: [
            Container(
              width: 110,
              child: TextField(
                onChanged: (String name) => setState(() => _numberOfIndividuals = name),
                keyboardType: TextInputType.text,
              ),
            ),
            const Padding(padding:  EdgeInsets.all(8),
              child:
               Text('Individuals'),
            ),
          ],
          ),

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
                  _speciesInput(),
                  _greenWeightsInput(),
                  _numberOfIndividualInput(),
                  Expanded(
                      child: Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const  EdgeInsets.symmetric(vertical: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      _saveButton(),
                                    ],
                                  ),
                                )

                              ])
                      )
                  )
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
              '  Catch Information',
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
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }
}
