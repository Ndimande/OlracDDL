import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:olracddl/theme.dart';

class TripTile extends StatelessWidget {
  int tripNumber;
  int setEntries;
  int tripWeight;
  Duration tripDuration;

  TripTile(
      {@required this.tripNumber,
      @required this.setEntries,
      @required this.tripWeight,
      @required this.tripDuration});

  Widget imageButton(String imagePath) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(25),
        height: 45,
        width: 60,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var tripUploaded = false;
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '$tripNumber',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('yyyy/MMM/dd, kk:mm')
                        .format(DateTime.now())
                        .toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: OlracColoursLight.olspsDarkBlue,
                    ),
                  ),
                  Text(
                    '$setEntries Sets',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    '${tripWeight}kg, $tripDuration',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
            ),
            tripUploaded
                ? imageButton('assets/images/successful_upload_icon.png')
                : imageButton('assets/images/upload_required_icon.png'),
          ],
        ),
      ),
    );
  }
}
