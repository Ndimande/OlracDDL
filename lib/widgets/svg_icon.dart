import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olrac_themes/olrac_themes.dart';

class SvgIcon extends StatelessWidget {
  final String assetPath;
  final double width;
  final double height;
  final Color color;

  const SvgIcon({
    @required this.assetPath,
    this.width = 64,
    this.height = 64,
    this.color = OlracColours.fauxPasBlue,
  });

  Widget _notFound() {
    return Stack(
      children: <Widget>[
        Container(
          width: width - 10,
          height: height - 10,
          color: OlracColours.ninetiesRed,
        ),
        Text(
          'SVG missing\n(path $assetPath)',
          style: const TextStyle(fontSize: 8, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (assetPath == null) {
      return _notFound();
    }
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      color: color,
    );
  }
}
