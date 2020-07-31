import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:olrac_widgets/westlake.dart';
import 'package:olracddl/localization/app_localization.dart';

class DownloadDialogBox extends StatefulWidget {
  @override
  _DownloadDialogBoxState createState() => _DownloadDialogBoxState();
}

class _DownloadDialogBoxState extends State<DownloadDialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.white,
      content: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Image(
              image: const AssetImage('assets/images/download_from_server.png'),
              width: 100, //Needs to be made dynamic
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context).getTranslatedValue('importing_data_from_olrac_ddm'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 20,
            ),
            StripButton(
              labelText: AppLocalizations.of(context).getTranslatedValue('acknowledge'),
              onPressed: () {},
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
