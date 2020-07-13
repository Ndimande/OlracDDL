import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olrac_widgets/olrac_widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
      color: Color.fromRGBO(43, 59, 100, 1),
      fontSize: _scaleText(fontSize),
      fontWeight: fontWeight,
      fontFamily: 'RobotoLight');

  Image _olracLogo(double imageWidth) => Image(
        image: const AssetImage('assets/images/olrac_logo.png'),
        width: _scaleImage(imageWidth),
      );

  Image _olspsLogo(double imageWidth) => Image(
        image: const AssetImage('assets/images/olsps_logo_darkblue.png'),
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

  Widget _developedBy() => Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Text('Developed By:', style: _fontStyle(14, FontWeight.w600)),
            const SizedBox(height: 15),
            _olspsLogo(275),
          ],
        ),
      );

  Widget _customisedFor() => Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Text(
              'Customised for the Azores\nHand-Line Fishery',
              style: _fontStyle(14, FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
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
            SizedBox(height: _screenHeight * 0.05),
            _developedBy(),
            SizedBox(height: _screenHeight * 0.05),
            _customisedFor(),
            SizedBox(height: _screenHeight * 0.05),
          ],
        ),
      ),
    );
  }
}
