import 'package:flutter/material.dart';
import 'package:olracddl/localization/app_localization.dart';
import 'package:olracddl/models/crew_member.dart';
import 'package:olracddl/models/skipper.dart';
import 'package:olracddl/repos/crew_member.dart';
import 'package:olracddl/theme.dart';
import 'package:olracddl/widgets/inputs/model_dropdown.dart';

import '../tiles/crew_member_tile.dart';

class AddCrewDialog extends StatefulWidget {

  Skipper skipper; 
  AddCrewDialog(this.skipper);

  @override
  _AddCrewDialogState createState() => _AddCrewDialogState();
}

class _AddCrewDialogState extends State<AddCrewDialog> {
  final List<CrewMember> _chosenCrewMembers = [];

  Widget _dropdownList() {
    
    final String crewMemberIds = _chosenCrewMembers.map((CrewMember cm) => cm.id).toList().join(',');
    return FutureBuilder(
      future: CrewMemberRepo().all(where: 'id NOT IN ($crewMemberIds) AND id NOT IN (${widget.skipper.id})'),
      builder: (context, AsyncSnapshot<List<CrewMember>> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final List<CrewMember> crewMembers = snapshot.data;

        return DDLModelDropdown<CrewMember>(
          fieldColor: OlracColoursLight.olspsExtraLightBlue,
          selected: null,
          onChanged: (CrewMember cm) {
            (cm != null)?
            setState(() {
              _chosenCrewMembers.add(cm);
              // ignore: list_remove_unrelated_type
              crewMembers.remove(_chosenCrewMembers);
            // ignore: unnecessary_statements
            }): (){};
          },
          items: crewMembers.map((CrewMember cm) {
            return DropdownMenuItem<CrewMember>(
              value: cm,
              child: Text(cm.name, style: Theme.of(context).textTheme.headline3,),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _chosenCrewMembersTiles() {
    return Container(
      child: ListView.builder(
        itemCount: _chosenCrewMembers.length,
        itemBuilder: (BuildContext context, int index) {
          final CrewMember crewMember = _chosenCrewMembers[index];
          return CrewTile(
              crewMemberName: crewMember.shortName,
              seamanId: int.parse(crewMember.seamanId),
              onPressDelete: () {
                setState(() {
                  _chosenCrewMembers.removeAt(index);





                });
              }); //created a seperated widget for this, crew_member_tile.dart
        },
      ),
    );
  }

  void onPressAddCrew() {
    Navigator.pop(context, _chosenCrewMembers);
  }

  Widget _addCrewButton() {
    return RaisedButton(
      child: Text(
        AppLocalizations.of(context).getTranslatedValue('add_crew'),
        style: Theme.of(context).textTheme.headline4,
      ),
      onPressed: onPressAddCrew,
    );
  }

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
              AppLocalizations.of(context).getTranslatedValue('crew_members'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(
              height: 25,
            ),
            _dropdownList(),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _chosenCrewMembersTiles(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _addCrewButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
