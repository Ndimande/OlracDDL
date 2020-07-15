import 'package:flutter/material.dart';





class WeatherConditionButton extends StatelessWidget {

  Widget weatherConditionItem(String imagePath){
    return
    GestureDetector(
          onTap: () {},
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                imagePath),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220, //should I use media Query for this?
      width: 300, //should I use media Query for this?
      child: GridView.count(
        childAspectRatio: 1.4533/1,
        crossAxisCount: 2, 
        children: <Widget>[
          weatherConditionItem('assets/images/wave.png'),
          weatherConditionItem('assets/images/cloud.png'), 
          weatherConditionItem('assets/images/partly_clouded.png'), 
          weatherConditionItem('assets/images/moon_phase.png'), 
        ],
      ),
    );
  }
}