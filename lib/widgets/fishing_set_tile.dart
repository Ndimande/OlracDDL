import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:olracddl/models/fishing_set.dart';
import 'package:olracddl/models/retained_catch.dart';
import 'package:olracddl/repos/retained_catch.dart';
import 'package:olracddl/theme.dart';

class FishingSetTile extends StatelessWidget {
  final int indexNumber;
  final FishingSet fishingSet;
  final Function onPressRetained;
  final Function onPressDisposal;
  final Function onPressMarineLife;

  const FishingSetTile({
    @required this.indexNumber,
    @required this.fishingSet,
    @required this.onPressDisposal,
    @required this.onPressMarineLife,
    @required this.onPressRetained,
  }) : assert(fishingSet != null);

  Widget imageButton(String imagePath, onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _catchEntries() {
    return FutureBuilder(
      future: RetainedCatchRepo().all(where: 'fishing_set_id = ${fishingSet.id}'),
      builder: (context, AsyncSnapshot<List<RetainedCatch>> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        return Text('${snapshot.data.length} Catch Entries', style: Theme.of(context).textTheme.headline3);
      },
    );
  }

  Widget _startDateTime() {
    return Text(
      DateFormat('yyyy/MMM/dd, kk:mm').format(fishingSet.startedAt).toString(),
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w900,
        color: OlracColoursLight.olspsDarkBlue,
      ),
    );
  }

  Widget _indexNumber() {
    return Builder(builder: (context){
      return Column(children: [
        Container(height: 20, child: fishingSet.isActive ? Icon(Icons.star,color: Colors.amber,size: 20) : Container()),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            fishingSet.id.toString(),
            style: Theme.of(context).textTheme.headline1,
          ),
        )
      ],);
//      return Padding(
//        padding: const EdgeInsets.all(8),
//        child: Text(
//          fishingSet.id.toString(),
//          style: Theme.of(context).textTheme.headline1,
//        ),
//      );
    });

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(
          children: [
            _indexNumber(),
            Container(
              padding: const EdgeInsets.all(5),
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _startDateTime(),
                  _catchEntries(),
                ],
              ),
            ),
            imageButton('assets/images/catch_icon.png', onPressRetained),
            imageButton('assets/images/disposal_icon.png', onPressDisposal),
            imageButton('assets/images/marine_life_icon.png', onPressMarineLife),
          ],
        ),
      ),
    );
  }
}
