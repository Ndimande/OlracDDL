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
    return _scale(fontSize, 260);
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

  Image _olspsLogo(double imageWidth) => Image(
        image: const AssetImage('assets/images/olsps_logo_darkblue.png'),
        width: _scaleImage(imageWidth),
      );

  Widget _appInfo() => Container(
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: _olracLogo(275),
            ),
            const Divider(color: Colors.transparent, thickness: 1),
            Text('Dynamic Data Logger',
                style: _fontStyle(16, FontWeight.w700),
                textAlign: TextAlign.center),
            //Text(AppData.packageInfo?.version, style: _fontStyle(10)),
            Text('Mobile Application',
                style: _fontStyle(16, FontWeight.normal),
                textAlign: TextAlign.center),
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
              'In co-operation with Ana Fraga',
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
            _appInfo(),
            _developedBy(),
            _customisedFor(),
            Column(
              children: [
                Image.asset(
                  'assets/images/sponsor_logo1.png',
                  height: 50,
                  width: _scaleImage(150),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/sponsor_logo2.png',
                        width: _scaleImage(100),
                      ),
                      Image.asset(
                        'assets/images/sponsor_logo3.png',
                        width: _scaleImage(170),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: _screenHeight * 0.02),
          ],
        ),
      ),
    );
  }
}
