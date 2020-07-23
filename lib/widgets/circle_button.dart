import 'package:flutter/material.dart';
import 'package:olracddl/theme.dart';

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final String text;

  const CircleButton({Key key, this.onTap, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double size = 35.0;

    return InkResponse(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(color: OlracColoursLight.olspsDarkBlue, shape: BoxShape.circle),
        child: Padding(
          padding: const EdgeInsets.only(top: 6, left: 12),
          child: Text(text, style: Theme.of(context).primaryTextTheme.headline6),
        ),
      ),
    );
  }
}