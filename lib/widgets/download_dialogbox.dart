import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:olrac_widgets/westlake.dart';

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
              'Importing Data from\nOlracDDM',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 20,
            ),
            StripButton(
              labelText: 'Acknowledge',
              onPressed: () {},
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
//  var _screenHeight = MediaQuery.of(context).size.height;
//  var _screenWidth = MediaQuery.of(context).size.width;
//    return BackdropFilter(
//        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//        child: AlertDialog(
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(15.0),
//          ),
//          backgroundColor: Colors.white,
//          content: Container(
//            width: _screenWidth * 0.9,
//            padding: EdgeInsets.all(20),
//            child: Column(
//              children: <Widget>[
//                Image(
//                  image: const AssetImage(
//                      'assets/images/download_from_server.png'),
//                  width: 100, //Needs to be made dynamic
//                ),
//                SizedBox(
//                  height: 20,
//                ),
//                Text(
//                  'Importing Data from\nOlracDDM',
//                  textAlign: TextAlign.center,
//                  style: Theme.of(context).textTheme.bodyText1,
//                ),
//                SizedBox(
//                  height: 20,
//                ),
//                StripButton(
//                  labelText: 'Acknowledge',
//                  onPressed: () {},
//                  color: Theme.of(context).accentColor,
//                ),
//              ],
//            ),
//          ),
//        ));
  }
}

// showDialog(
//               builder: (_) => DownloadDialogBox(),
//               context: context,
//             barrierDismissible: false,)
