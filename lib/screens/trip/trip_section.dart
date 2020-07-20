import 'package:flutter/material.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/models/current_fishing_method.dart';
import 'package:olracddl/models/fishing_method.dart';
import 'package:olracddl/models/trip.dart';
import 'package:olracddl/screens/fishing_method.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/elapsed_counter.dart';
import 'package:olracddl/widgets/numbered_boat.dart';
import 'package:olracddl/widgets/svg_icon.dart';

class TripSection extends StatelessWidget {
  final Trip trip;
  final bool hasActiveHaul;

  const TripSection({
    @required this.trip,
    this.hasActiveHaul = false,
  });

  Widget _started() {
    return Builder(builder: (BuildContext context) {
      return Row(
        children: [
          Text('Started: ', style: Theme.of(context).textTheme.headline6),
          Text(friendlyDateTime(trip.startedAt), style: Theme.of(context).textTheme.headline6)
        ],
      );
    });
  }

  Widget _duration() {
    return Builder(builder: (BuildContext context) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Duration: ', style: Theme.of(context).textTheme.headline6),
          ElapsedCounter(style: Theme.of(context).textTheme.headline6, startedDateTime: trip.startedAt),
        ],
      );
    });
  }

  Widget _locationButton() {
    return IconButton(
      icon: Image.asset('assets/images/location_icon.png'),
      onPressed: () {},
    );
  }

  Widget _fishingMethodButton() {
    Future<FishingMethod> currentFM() async {
      return await CurrentFishingMethod.get();
    }

    return FutureBuilder(
      future: currentFM(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        final FishingMethod fm = snapshot.data;
        return IconButton(
          icon: SvgIcon(assetPath: fm.svgPath, color: OlracColoursLight.olspsDarkBlue),
          onPressed: () async {
            final FishingMethod method =
                await Navigator.push(context, MaterialPageRoute(builder: (_) => FishingMethodScreen()));
            if (method != null) {
              CurrentFishingMethod.set(method);
            }
          },
        );
      },
    );
  }

  Widget tripInfo() {
    return Builder(builder: (BuildContext context) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _started(),
              _duration(),
            ],
          ),
          _locationButton(),
          _fishingMethodButton(),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              NumberedBoat(number: trip.id),
              const SizedBox(width: 5),
              tripInfo(),
            ],
          ),
        ],
      ),
    );
  }
}
