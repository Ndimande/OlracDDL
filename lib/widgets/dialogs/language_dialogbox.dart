import 'package:flutter/material.dart';

import '../../main.dart';

class Language {
  final int id;
  final String name;
  final String flag;
  final String languageCode;

  Language(this.id, this.name, this.flag, this.languageCode);

  // static List<Language> languageList() {
  //   return <Language>[
  //     Language(1, '🇬🇧', 'English', 'en'),
  //     Language(2, '🇵🇹', 'Portuguese', 'pt'),
  //   ];
  // }
}

class LanguageDialogBox extends StatefulWidget {
  @override
  _LanguageDialogBoxState createState() => _LanguageDialogBoxState();
}

class _LanguageDialogBoxState extends State<LanguageDialogBox> {
  void _changeLanguage(Language language) {
    Locale _temp;
    switch (language.languageCode) {
      case 'en':
        _temp = Locale(language.languageCode, 'US');
        break;
      case 'pt':
        _temp = Locale(language.languageCode, 'PT');
        break;
      default:
        _temp = Locale(language.languageCode, 'US');
    }

    MyApp.setLocale(context, _temp); 

  }


  Language english = Language(1, '🇬🇧', 'English', 'en');
  Language portuguese = Language(2, '🇵🇹', 'Portuguese', 'pt'); 


  @override

  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.white,
      content: Container(
        height: 130,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                _changeLanguage(english);
                Navigator.pop(context); 
              },
              child: Row(
                children: [
                  const Text('🇬🇧'),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text('English'),
                ],
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                _changeLanguage(portuguese);
                Navigator.pop(context); 
              },
              child: Row(
                children: [
                  const Text('🇵🇹'),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text('Portuguese'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
