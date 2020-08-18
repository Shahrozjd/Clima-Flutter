import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  double Longitude;
  double Latitude;

  @override
  void initState() {
    super.initState();
    getlocation();

  }

  void getlocation() async {
    WeatherModel weatherModel = new WeatherModel();
    var weatherdata = await weatherModel.getlocationweather();

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(weatherdata);
    }));

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
