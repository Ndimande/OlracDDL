import 'package:flutter/material.dart';
import 'package:olrac_widgets/westlake.dart';
import 'package:olracddl/localization/app_localization.dart';
import 'package:olracddl/widgets/dialogs/add_crew_dialogbox.dart';
import 'package:olracddl/widgets/dialogs/language_dialogbox.dart';
import 'package:olracddl/widgets/inputs/model_dropdown.dart';

import '../theme.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Widget _listTile({IconData iconData, String text, Function onTap}) {
    return Builder(
      builder: (BuildContext context) {
        return ListTile(
          leading:
              Icon(iconData, color: OlracColoursLight.olspsDarkBlue, size: 36),
          title: Text(text, style: Theme.of(context).textTheme.headline2),
          onTap: onTap,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WestlakeScaffold(
      title: AppLocalizations.of(context).getTranslatedValue('settings'),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: _listTile(
            iconData: Icons.language,
            text: AppLocalizations.of(context).getTranslatedValue('select_language'),
            onTap: () {
              showDialog(
                builder: (_) => LanguageDialogBox(),
                context: context,
              );
            }),
      ),
    );
  }

}
