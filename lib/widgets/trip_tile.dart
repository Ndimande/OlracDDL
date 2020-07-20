import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:olracddl/models/trip.dart';
import 'package:olracddl/theme.dart';

@immutable
class TripTile extends StatelessWidget {
  final Trip trip;
  final VoidCallback onPressed;
  final int index;

  const TripTile({
    this.trip,
    this.onPressed,
    this.index,
  });

  Widget imageButton(String imagePath) {
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
    return Builder(builder: (context) {
      return Container(
        padding: const EdgeInsets.all(5),
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('yyyy/MMM/dd, kk:mm').format(DateTime.now()).toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: OlracColoursLight.olspsDarkBlue,
              ),
            ),
            Text('${trip.fishingSets.length} Sets', style: Theme.of(context).textTheme.headline3),
            Text('Xkg, X', style: Theme.of(context).textTheme.headline3),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 3,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: FlatButton(
        onPressed: onPressed,
        child: Container(
          height: 120,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  '1',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              _details(),
              trip.isUploaded
                  ? imageButton('assets/images/successful_upload_icon.png')
                  : imageButton('assets/images/upload_required_icon.png'),
            ],
          ),
        ),
      ),
    );
  }
}
