import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:olrac_themes/olrac_themes.dart';
import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/localization/app_localization.dart';
import 'package:olracddl/models/fishing_method.dart';
import 'package:olracddl/repos/fishing_method.dart';
import 'package:olracddl/theme.dart';
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
          height: constraints.maxWidth * 0.32, // we have to use height for width because height constraint is infinite
          color: OlracColoursLight.olspsDarkBlue,
          assetPath: method.svgPath,
        ),
      );
    });

    return Builder(builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(25))),
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

  Widget _fishingMethodGrid(List<FishingMethod> fishingMethods) {
    return Container(
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
    );
  }

  Future<List<FishingMethod>> _getFishingMethods() async {
    return await FishingMethodRepo().all();
  }

  @override
  Widget build(BuildContext context) {
    return WestlakeScaffold(
      title: AppLocalizations.of(context).getTranslatedValue('fishing_method'),
      body: FutureBuilder(
          future: FishingMethodRepo().all(),
          builder: (context, AsyncSnapshot<List<FishingMethod>> snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            return _fishingMethodGrid(snapshot.data);
          }),
    );
  }
}
