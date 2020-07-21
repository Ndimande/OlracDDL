import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olrac_widgets/westlake/strip_button.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/datetime_editor.dart';
import 'package:olracddl/widgets/location_editor.dart';

class EndTripInformationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.white,
      content: Container(
        height: 700,
        //width: 500,
        padding: const EdgeInsets.all(2),
        child: Column(
          children: <Widget>[
            Text(
              'End Trip Information',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),

            DateTimeEditor(
                    title: 'Date and Time',
                    initialDateTime: DateTime.now(),
                    onChanged: () {},
                    titleStyle: Theme.of(context).textTheme.headline3,
                    fieldColor: OlracColoursLight.olspsExtraLightBlue,
                  ),
            LocationEditor(
              subTitleStyle: Theme.of(context).textTheme.headline6,
              fieldColor: OlracColoursLight.olspsExtraLightBlue,
              title: 'Location',
              titleStyle: Theme.of(context).textTheme.headline3,
              location: Location(latitude: 0, longitude: 0),
              onChanged: (Location l) {},
            ),
            Container(
                child:
                Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Set Duration',textAlign: TextAlign.left,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                  ],

                )
            ),
            const SizedBox(
              height: 5,
            ),

            Container(

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RaisedButton(
                    color: Colors.grey,
                    //  labelText:'Mins',
                    onPressed: (){},
                    child: Container(
                      height: 40,
                      width: 70,
                      alignment: Alignment.bottomRight,
                      child: const Text('Hours ',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                    height: 60,
                  ),
                  RaisedButton(
                    color: Colors.grey,
                  //  labelText:'Mins',
                    onPressed: (){},
                    child: Container(
                      height: 40,
                      width: 70,
                      alignment: Alignment.bottomRight,
                      child: const Text('Mins',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 5,
            ),
            Container(
                child:
                Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Number of Hooks/Traps',textAlign: TextAlign.left,style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RaisedButton(
                      color: Colors.grey,
                      //  labelText:'Mins',
                      onPressed: (){},
                      child: Container(
                        height: 40,
                        width: 70,
                        alignment: Alignment.bottomRight,
                        child: const Text('Hooks',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                      //height: 60,
                    ),
                    RaisedButton(
                      color: Colors.grey,
                      //  labelText:'Mins',
                      onPressed: (){},
                      child: Container(
                        height: 40,
                        width: 70,
                        alignment: Alignment.bottomRight,
                        child: const Text('Traps',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 20,
              height: 5,
            ),
            Container(
                child:
                Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Max # of Lines Used',textAlign: TextAlign.left,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                  ],
                )),
            const SizedBox(
              height: 5,
            ),
            Container(
              //color: Colors.yellow,
              width: 300,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RaisedButton(
                      color: Colors.grey,
                      //  labelText:'Mins',
                      onPressed: (){},
                      child: Container(
                        height: 40,
                        width: 70,
                        alignment: Alignment.bottomRight,
                        child: const Text('Lines  ',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RaisedButton(
                  child: Text(
                    'Save',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
