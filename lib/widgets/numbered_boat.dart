import 'package:flutter/material.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/svg_icon.dart';

class NumberedBoat extends StatelessWidget {
  final int number;
  final double size;
  final Color color;

  const NumberedBoat({this.number, this.size = 64, this.color = OlracColoursLight.olspsDarkBlue});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: size,
          height: size,
          child: SvgIcon(
            color: color,
            assetPath: 'assets/icons/Boat.svg',
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            number.toString(),
            style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.white),
          ),
        )
      ],
    );
  }
}

