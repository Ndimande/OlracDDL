import 'package:flutter/material.dart';
import 'package:olrac_themes/olrac_themes.dart';
import 'package:olrac_widgets/common/gradient_background.dart';
import 'package:olracddl/app_data.dart';

const double drawerLabelFontSize = 20;
const double drawerTextFontSize = 26;

Widget _drawerHeader() {
  return Builder(builder: (context) {
//    final vesselName = Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: <Widget>[
//        Text(
//          'Vessel Name',
//          style: Theme.of(context).textTheme.headline2,
//        ),
//        Text(
//          'TODO',
//          style: Theme.of(context).textTheme.headline1,
//          overflow: TextOverflow.ellipsis,
//        ),
//      ],
//    );

    final username = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: Theme.of(context).textTheme.headline2,
        ),
        Text(
          AppData.profile.username,
          style: Theme.of(context).textTheme.headline1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );

    return DrawerHeader(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(0),
      child: Container(
        color: const Color.fromRGBO(255, 255, 255, 0.5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          color: const Color.fromRGBO(122, 157, 224, 0.25),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      username,
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BackButton(color: Theme.of(context).primaryColor),
                ],
              )
            ],
          ),
        ),
      ),
    );
  });
}

class MainDrawer extends StatelessWidget {
  Widget _listTile({IconData iconData, String text, Function onTap}) {
    return Builder(
      builder: (BuildContext context) {
        return ListTile(
          leading: Icon(iconData, color: OlracColours.olspsDarkBlue, size: 36),
          title: Text(text, style: Theme.of(context).textTheme.headline2),
          onTap: onTap,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Container(
        child: GradientBackground(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              _drawerHeader(),
              Column(
                children: [
                  _listTile(
                    iconData: Icons.history,
                    text: 'Trip History',
                    onTap: () => null,
                  ),
                  _listTile(
                    iconData: Icons.settings,
                    text: 'Settings',
                    onTap: () => null,
                  ),
                  _listTile(
                    iconData: Icons.info,
                    text: 'About',
                    onTap: () => null,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
