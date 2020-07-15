import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:olracddl/theme.dart';

class FishingSetTile extends StatelessWidget {
  int setNumber;
  int catchEntries;

  FishingSetTile({
    @required this.setNumber,
    @required this.catchEntries,
  });

  Widget imageButton(String imagePath){
    return
    GestureDetector(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(5),
            height: 40,
            width: 40,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                imagePath),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
}

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '$setNumber',
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
                    '${catchEntries} Catch Entries',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
            ),
            imageButton('assets/images/catch_icon.png'),
            imageButton('assets/images/disposal_icon.png'),
            imageButton('assets/images/marine_life_icon.png'),
          ],
        ),
      ),
    );
  }
}
