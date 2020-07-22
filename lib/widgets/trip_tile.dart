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

  Widget _indexNumber() {
    return Builder(builder: (context){
      return Column(children: [
        Container(height: 20, child: trip.isActive ? Icon(Icons.star,color: Colors.amber,size: 20) : Container()),
        SizedBox(height: 11),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            listIndex.toString(),
            style: Theme.of(context).textTheme.headline1,
          ),
        )
      ],);
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
              _indexNumber(),
              _details(),
              if (trip.isUploaded) imageButton('assets/images/successful_upload_icon.png') else imageButton('assets/images/upload_required_icon.png'),
            ],
          ),
        ),
      ),
    );
  }
}
