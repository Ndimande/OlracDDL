import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:olrac_themes/olrac_themes.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/data/fishing_methods.dart';
import 'package:olracddl/models/current_fishing_method.dart';
import 'package:olracddl/models/fishing_method.dart';
import 'package:olracddl/screens/start_trip_screen.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/svg_icon.dart';

const double iconBaseSize = 200;

class FishingMethodScreen extends StatelessWidget {
  Future<void> _onCardPressed(context, method) async {
    // todo save selected FM in DB
    await CurrentFishingMethod.set(method);
    Navigator.push(context, MaterialPageRoute(builder: (_) => StartTripScreen()));
  }

  Widget _buildFishingMethodCard(FishingMethod method) {
    final Widget svg = LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        child: SvgIcon(
          height: constraints.maxWidth * 0.32, // we have to use height for width because height constraint is infinite
          color: OlracColoursLight.olspsDarkBlue,
          assetPath: method.svgPath,
        ),
      );
    });

    return Builder(builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25))
        ),
        margin: const EdgeInsets.all(12),
        child: FlatButton(
          padding: const EdgeInsets.all(8),
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
                    '(${method.abbreviation})',
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
    return WestlakeScaffold(
      title: 'Fishing Method',
      body: Container(
        padding: const EdgeInsets.all(2),
        child: OrientationBuilder(
          builder: (context, orientation) {
            final int columnCount = orientation == Orientation.portrait ? 2 : 4;
            final rows = chunk(defaultFishingMethods, columnCount);

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