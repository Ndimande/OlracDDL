import 'package:flutter/material.dart';
import 'package:olrac_widgets/westlake.dart';
import 'package:olracddl/localization/app_localization.dart';
import 'package:olracddl/widgets/dialogs/language_dialogbox.dart';

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
      leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
            onPressed: () => Navigator.pop(context),
          ),
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
