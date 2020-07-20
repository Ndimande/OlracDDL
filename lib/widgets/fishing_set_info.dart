import 'package:flutter/material.dart';
import 'package:olracddl/models/fishing_set.dart';

class FishingSetInfo extends StatelessWidget {
  final FishingSet fishingSet;

  FishingSetInfo({this.fishingSet});

  Widget _indexIcon() {
    return Text('s');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _indexIcon(),
      ],
    );
  }

}