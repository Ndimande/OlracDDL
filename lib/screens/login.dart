import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olrac_widgets/olrac_widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _screenWidth;
  double _screenHeight;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  double _scale(double fontSize, double ratio) {
    final scaledFontSize = _screenWidth / ratio * fontSize;
    return scaledFontSize;
  }

  double _scaleText(double fontSize) {
    return _scale(fontSize, 250);
  }

  double _scaleImage(double imageSize) {
    return _scale(imageSize, 500);
  }

  TextStyle _fontStyle(double fontSize, FontWeight fontWeight) => TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: _scaleText(fontSize),
      fontWeight: fontWeight,
      fontFamily: 'RobotoLight');

  Image _olracLogo(double imageWidth) => Image(
        image: const AssetImage('assets/images/olrac_logo.png'),
        width: _scaleImage(imageWidth),
      );

  Widget _appInfo() => Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          children: <Widget>[
            _olracLogo(300),
            const Divider(color: Colors.transparent, thickness: 1),
            Text('Dynamic Data Logger', style: _fontStyle(16, FontWeight.w700), textAlign: TextAlign.center),
            //Text(AppData.packageInfo?.version, style: _fontStyle(10)),
            Text('Mobile Application', style: _fontStyle(16, FontWeight.normal), textAlign: TextAlign.center),
          ],
        ),
      );

  Widget _loginButton() => Container(
        margin: const EdgeInsets.all(5),
        child: StripButton(
          labelText: '      Log In      ',
          onPressed: () {},
        ),
      );

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GradientBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: _screenHeight * 0.2),
            _appInfo(),
            _loginButton(),
            SizedBox(height: _screenHeight * 0.02),
          ],
        ),
      ),
    );
  }
}
