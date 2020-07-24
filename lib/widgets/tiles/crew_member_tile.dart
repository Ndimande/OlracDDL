import 'package:flutter/material.dart';

import '../../theme.dart';

class CrewTile extends StatelessWidget {
  String crewMemberName;
  int seamanId;
  VoidCallback onPressDelete;

  CrewTile({
    @required this.crewMemberName,
    @required this.seamanId,
    @required this.onPressDelete,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.fiber_manual_record,
          size: 15,
          color: OlracColoursLight.olspsDarkBlue,
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                crewMemberName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: OlracColoursLight.olspsDarkBlue,
                ),
              ),
              Text(
                seamanId.toString(),
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: Align(
                alignment: Alignment.centerRight,
                child: RawMaterialButton(
                  onPressed: onPressDelete,
                  elevation: 2.0,
                  fillColor: OlracColoursLight.olspsRed,
                  child: const Icon(
                    Icons.delete,
                    size: 15,
                    color: Colors.white,
                  ),
                  shape: const CircleBorder(),
                )),
          ),
        ),
      ],
    );
  }
}
