import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:olrac_widgets/olrac_widgets.dart';
import 'package:olracddl/http/get_species.dart';

import 'package:olracddl/localization/app_localization.dart';
import 'package:olracddl/models/species.dart';
import 'package:olracddl/providers/dio.dart';
import 'package:olracddl/repos/species.dart';

import '../get_lookup_data.dart';

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

    getDdmData(); 

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }


   Future<void> getDdmData() async {
     DioProvider().init(); 
     //await storeSpecies();
     await storeSeaBottomTypes();
     await storePorts();
     await storeVesselNames();
     await storeFishingAreas();
     await storeCrewMembers();
     await storeSkippers();
     await storeCatchConditions();
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
        //margin: const EdgeInsets.only(bottom: 15,),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: _olracLogo(200),
            ),
            const Divider(color: Colors.transparent, thickness: 1),
            Text(
                AppLocalizations.of(context)
                    .getTranslatedValue('dynamic_data_logger'),
                style: _fontStyle(14, FontWeight.w700),
                textAlign: TextAlign.center),
            //Text(AppData.packageInfo?.version, style: _fontStyle(10)),
            Text(
                AppLocalizations.of(context)
                    .getTranslatedValue('mobile_application'),
                style: _fontStyle(14, FontWeight.normal),
                textAlign: TextAlign.center),
          ],
        ),
      );

  Widget _developedBy() => Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Text(
                AppLocalizations.of(context).getTranslatedValue('developed_by'),
                style: _fontStyle(14, FontWeight.w600)),
            const SizedBox(height: 15),
            _olspsLogo(200),
          ],
        ),
      );

  Widget _customisedFor() => Container(
        child: Column(
          children: <Widget>[
            Text(
              AppLocalizations.of(context)
                  .getTranslatedValue('in_cooperation_with_ana_fraga'),
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
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(
                    'assets/images/logo5.png',
                    width: _scaleImage(150),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/sponsor_logo1.png',
                        width: _scaleImage(150),
                      ),
                      Image.asset(
                        'assets/images/logo4.png',
                        width: _scaleImage(170),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
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
