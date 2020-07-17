import 'package:flutter/material.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/datetime_editor.dart';
import 'package:olracddl/widgets/location_editor.dart';

class EndTripDialogBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.white,
      content: Container(
        height: 475,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text(
              'End Trip Information',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(
              height: 10,
            ),
            DateTimeEditor(
              title: 'Date and Time',
              initialDateTime: DateTime.now(),
              onChanged: () {},
              titleStyle: Theme.of(context).textTheme.headline2,
              fieldColor: OlracColoursLight.olspsExtraLightBlue,
            ),
            LocationEditor(
              subTitleStyle: Theme.of(context).textTheme.headline3,
              fieldColor: OlracColoursLight.olspsExtraLightBlue,
              title: 'Location',
              titleStyle: Theme.of(context).textTheme.headline2,
              location: Location(latitude: 0, longitude: 0),
              onChanged: (Location l) {},
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
