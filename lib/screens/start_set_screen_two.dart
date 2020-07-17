////import 'dart:html';
//import 'package:olrac_utils/olrac_utils.dart';
//import 'package:flutter/material.dart';
//import 'package:olrac_utils/units.dart';
//import 'package:olrac_widgets/olrac_widgets.dart';
//import 'package:olracddl/theme.dart';
//import '../widgets/weather_condition_button.dart';
//
//
//class StartSetScreenTwo extends StatefulWidget {
//  @override
//  _StartSetScreenTwoState createState() => _StartSetScreenTwoState();
//}
//
//class _StartSetScreenTwoState extends State<StartSetScreenTwo> {
//  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
//
//  //unique identifier for new set
//  int _id;
//
//  /// When the set started
//  DateTime _startedAt;
//
//  /// When the set ended
//  DateTime _endedAt;
//
//  /// GPS Start Location
//  Location _startLocation;
//
//  /// GPS End Location
//  Location _endLocation;
//
//  String _fishingArea;
//
//  /// Sea bottom depth and unit
//  String _seaBottomDepth; //************ needs to be changed
//  LengthUnit _seaBottomDepthUnit;
//
//  /// sea bottom type
//  int _minimumHookSize;
//
//  bool _allValid() {
//    if (_startedAt == null) {
//      return false;
//    } else {
//      return true;
//    }
//  }
//
//  Widget _dateTimeInput() {
//    return Container(
//      margin: const EdgeInsets.symmetric(vertical: 8),
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: [
//          Text('Target Species',
//              style: Theme.of(context).textTheme.headline2),
//          const SizedBox(height: 15),
//          TextField(
//                    //onChanged: (String name) => setState(() => _name = name),
//                    //keyboardType: TextInputType.text,
//                    ),
//            ],
//          )
//    );
//  }
//
//  Widget _minimumHookSizeInput() {
//    return Container(
//      margin: const EdgeInsets.symmetric(vertical: 8),
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: [
//          Row(
//            children: [
//              Text('Notes',
//                  style: Theme.of(context).textTheme.headline2),
//              SizedBox(width: 5),
//              Icon(Icons.camera_alt, color: OlracColoursLight.olspsDarkBlue,),
//            ],
//          ),
//          const SizedBox(height: 15),
//          TextField(
//            onChanged: (String name) => setState(() => _seaBottomDepth = name),
//            keyboardType: TextInputType.text,
//          )
//        ],
//      ),
//    );
//  }
//
//  Widget _body() {
//    return Container(
//      margin: EdgeInsets.symmetric(
//        horizontal: 20,
//        vertical: 10,
//      ),
//      child: Stack(
//        children: [
//          SingleChildScrollView(
//            padding: const EdgeInsets.symmetric(horizontal: 20),
//            child: Column(children: [
//              const SizedBox(height: 70),
//            ]),
//          ),
//          Container(
//            margin: const EdgeInsets.only(right: 12),
//            child: Center(
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.end,
//                children: [
//                  _dateTimeInput(),
//                  const SizedBox(height: 15),
//                  Align(
//                    alignment: Alignment.centerLeft,
//                    child: Text(
//                      'Weather Conditions',
//                      style: Theme.of(context).textTheme.headline2,
//                    ),
//                  ),
//                  const SizedBox(height: 15),
//                  WeatherConditionButton(),
//                  const SizedBox(height: 15),
//                  _minimumHookSizeInput(),
//                  const SizedBox(height: 15),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: [
//                      _saveButton()
//                    ],
//                  ),
//                ],
//              ),
//            ),
//          )
//        ],
//      ),
//    );
//  }
//
//  StripButton _saveButton() {
//    return StripButton(
//        color: _allValid() ? Theme.of(context).accentColor : OlracColoursLight.olspsGrey,
//        onPressed: _allValid() ? (){}: (){},
//        labelText: 'Save'
//        );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return WestlakeScaffold(
//      scaffoldKey: _scaffoldKey,
//      title: 'Start Fishing Set',
//      body: _body(),
//      actions: [Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: [
//          Spacer(),
//          BackButton(),
//        ],
//      )],
//    );
//  }
//}
