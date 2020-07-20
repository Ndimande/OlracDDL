import 'package:flutter/material.dart';
import 'package:olrac_widgets/olrac_widgets.dart';

class MarineLifeScreen extends StatefulWidget {
  @override
  _MarineLifeScreenState createState() => _MarineLifeScreenState();
}

class _MarineLifeScreenState extends State<MarineLifeScreen> {
  Widget _body() {
    return Text('marine life');
  }

  @override
  Widget build(BuildContext context) {
    return WestlakeScaffold(
      body: _body(),
    );
  }
}
