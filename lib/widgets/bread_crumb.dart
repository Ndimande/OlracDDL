import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olracddl/screens/trip/trip_screen.dart';
import 'package:olracddl/theme.dart';




class BreadCrumb extends StatelessWidget {
  int tripNumber;
  int setNumber;
  String fishingSetEventType;
  int eventNumber;
 

  BreadCrumb(
      {@required this.tripNumber,
      @required this.setNumber,
      @required this.fishingSetEventType,
      this.eventNumber});

  Widget breadCrumbItem(BuildContext context, String itemText, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => screen));
      },
      child: Container(
        child: Text(
          itemText,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      margin: const EdgeInsets.symmetric(vertical: 20),
      color: OlracColoursLight.olspsDarkBlue.shade100,
      width: double.infinity,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
//            breadCrumbItem(context, 'Trip $tripNumber', TripScreen(tripNumber)), //screen needs to be imported
//              SvgPicture.asset(
//                'assets/icons/image/arrow_darkblue_icon.svg',
//                height: 20,
//              ),
//            breadCrumbItem(context, 'Set $setNumber', SetScreen(id: setScreen)), //screen needs to be imported
//              SvgPicture.asset(
//                'assets/icons/image/arrow_darkblue_icon.svg',
//                height: 20,
//              ),
//              breadCrumbItem(context, '$fishingSetEventType', EventScreen(id: fishingEventType)), //screen needs to be imported
//            if (eventNumber != null)
//              SvgPicture.asset(
//                'assets/icons/image/arrow_darkblue_icon.svg',
//                height: 20,
//              ),
//            if (eventNumber != null)
//              breadCrumbItem(context, '# $eventNumber', EventNumberScreen(id: eventNumber)), //screen needs to be imported
          ],
        ),
      ),
    );
  }
}
