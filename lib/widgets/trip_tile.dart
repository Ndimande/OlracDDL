import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:olracddl/models/trip.dart';
import 'package:olracddl/theme.dart';

@immutable
class TripTile extends StatelessWidget {
  final Trip trip;
  final VoidCallback onPressed;
  final int listIndex;

  const TripTile({
    this.trip,
    this.onPressed,
    this.listIndex,
  });

  String get _tripDurationString {
    Duration tripDuration;

    if (trip.isActive) {
      tripDuration = DateTime.now().difference(trip.startedAt);
    } else {
      tripDuration = trip.endedAt.difference(trip.startedAt);
    }

    final String hours = tripDuration.inHours.toString();
    final String minutes = tripDuration.inMinutes.toString();

    return '${hours}h${minutes}m';
  }

  Widget _uploadIcon() {
    final String imagePath =
    trip.isUploaded ? 'assets/images/successful_upload_icon.png' : 'assets/images/upload_required_icon.png';
    return Container(
      margin: const EdgeInsets.all(25),
      height: 45,
      width: 60,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fill),
      ),
    );
  }

  Widget _details() {
    final Widget startDateTime = Text(
      DateFormat('yyyy/MMM/dd, kk:mm').format(trip.startedAt).toString(),
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: OlracColoursLight.olspsDarkBlue),
    );

    return Builder(builder: (context) {
      return Container(
        padding: const EdgeInsets.all(5),
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            startDateTime,
            Text('${trip.fishingSets.length} Sets', style: Theme.of(context).textTheme.headline3),
            Text('Xkg, $_tripDurationString', style: Theme.of(context).textTheme.headline3),
          ],
        ),
      );
    });
  }


  Widget _indexNumber() {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          listIndex.toString(),
          style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 50),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 15),
      elevation: 3,
      shape: _cardShape(),
      child: FlatButton(
        onPressed: onPressed,
        child: Stack(
          children: [
            if(trip.isActive) _activeStar(),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _indexNumber(),
                      _details(),
                    ]
                  ),
                  _uploadIcon(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

ShapeBorder _cardShape() {
  return const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
  );
}

Widget _activeStar() {
  return const Icon(Icons.star, color: Colors.amber, size: 20);
}