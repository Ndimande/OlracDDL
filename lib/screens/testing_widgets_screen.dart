import 'package:flutter/material.dart';
import 'package:olrac_widgets/olrac_widgets.dart';


class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return WestlakeScaffold(
      body: Text('Hello'),
    );
  }
}
