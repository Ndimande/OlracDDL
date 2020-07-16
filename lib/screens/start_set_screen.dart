//import 'dart:html';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:flutter/material.dart';
import 'package:olrac_utils/units.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/datetime_editor.dart';
import 'package:olracddl/widgets/location_editor.dart';
import '../widgets/weather_condition_button.dart';

import '../models/fishing_area.dart';

enum Page {
  One,
  Two,
}

class StartSetScreen extends StatefulWidget {
  @override
  _StartSetScreenState createState() => _StartSetScreenState();
}

class _StartSetScreenState extends State<StartSetScreen> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  //unique identifier for new set
  int _id;

  /// When the set started
  DateTime _startedAt;

  /// When the set ended
  DateTime _endedAt;

  /// GPS Start Location
  Location _startLocation;

  /// GPS End Location
  Location _endLocation;

  String _fishingArea;

  /// Sea bottom depth and unit
  String _seaBottomDepth; //************ needs to be changed
  LengthUnit _seaBottomDepthUnit;

  /// sea bottom type
  int _minimumHookSize;

  Page _page = Page.One;

  bool _allValid() {
    if (_startedAt == null) {
      return false;
    } else {
      return true;
    }
  }

  Widget _dateTimeInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Date, Time and Location', style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: 15),
          Row(
            children: <Widget>[
              Flexible(
                flex: 5,
                child: DateTimeEditor(
                  initialDateTime: DateTime.now(),
                  title: 'foo',
                  onChanged: () {},
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
          Text('Fishing Area (Statistical Rectangle)', style: Theme.of(context).textTheme.headline3),
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
            keyboardType: TextInputType.text,
          )
        ],
      ),
    );
  }

  Widget _seaBottomTypeInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sea Bottom Type', style: Theme.of(context).textTheme.headline3),
          const SizedBox(height: 15),
          TextField(
            onChanged: (String name) => setState(() => _seaBottomDepth = name),
            keyboardType: TextInputType.text,
          )
        ],
      ),
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
            onChanged: (String name) => setState(() => _seaBottomDepth = name),
            keyboardType: TextInputType.text,
          )
        ],
      ),
    );
  }

  StripButton _saveButton() {
    return StripButton(
        color: _allValid() ? Theme.of(context).accentColor : OlracColoursLight.olspsGrey,
        onPressed: _allValid() ? () {} : () {},
        labelText: 'Save');
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
          _seaBottomTypeInput(),
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
          _dateTimeInput(),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Weather Conditions',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          const SizedBox(height: 15),
          WeatherConditionButton(),
          const SizedBox(height: 15),
          _minimumHookSizeInput(),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_saveButton()],
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return WestlakeScaffold(
      scaffoldKey: _scaffoldKey,
      title: 'Start Fishing Set',
      body: _page == Page.One ? _page1() : _page2(),
//      actions: [Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: [
//          Spacer(),
//          BackButton(),
//        ],
//      )],
    );
  }
}
