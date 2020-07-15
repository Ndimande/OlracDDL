import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:olrac_themes/olrac_themes.dart';
import 'package:olracddl/data/fishing_methods.dart';
import 'package:olracddl/data/svg_icons.dart';
import 'package:olracddl/models/fishing_method.dart';
import 'package:olracddl/widgets/svg_icon.dart';

const double iconBaseSize = 200;

class FishingMethodScreen extends StatelessWidget {
  Future<void> _onCardPressed(context, method) async {
    Navigator.pop(context, method);
  }

  Widget _buildFishingMethodCard(FishingMethod method) {
    final Widget svg = LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        child: SvgIcon(
          height: constraints.maxWidth * 0.4, // we have to use height for width because height constraint is infinite
          color: OlracColours.olspsDarkBlue,
          assetPath: SvgIcons.path(method.name),
        ),
      );
    });

    return Builder(builder: (BuildContext context) {
      return Card(
        margin: const EdgeInsets.all(2),
        child: FlatButton(
          padding: const EdgeInsets.all(2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              svg,
              Column(
                children: <Widget>[
                  Text(
                    method.name,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '(${method.name})',
                    style: Theme.of(context).textTheme.headline6.copyWith(color: OlracColours.olspsDarkBlue),
                  ),
                ],
              )
            ],
          ),
          onPressed: () async => _onCardPressed(context, method),
        ),
      );
    });
  }

  dynamic chunk(list, int perChunk) =>
      list.isEmpty ? list : ([list.take(perChunk), ...chunk(list.skip(perChunk), perChunk)]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Fishing Method')),
      body: Container(
        color: OlracColours.fauxPasBlue,
        padding: const EdgeInsets.all(2),
        child: OrientationBuilder(
          builder: (context, orientation) {
            final int columnCount = orientation == Orientation.portrait ? 2 : 4;
            final rows = chunk(fishingMethods, columnCount);

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: rows.map<Widget>((fms) {
                return Expanded(
                  child: Row(
                    children: fms.map<Widget>((FishingMethod fm) {
                      return Expanded(
                        child: _buildFishingMethodCard(fm),
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
