import 'package:flutter/material.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/model_dropdown.dart';

import 'crew_member_tile.dart';

class AddCrewDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.white,
      content: Container(
        height: 475,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text(
              'Crew Members',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(
              height: 25,
            ),
            DDLModelDropdown(
              items: [],
              labelTheme: false,
              selected: null,
              onChanged: null,
              fieldColor: OlracColoursLight.olspsExtraLightBlue,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return CrewTile(crewMemberName: 'Black Beard', seamanId: 12123,); //created a seperated widget for this, crew_member_tile.dart
                    }),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      child: Text(
                        'Add Crew',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
