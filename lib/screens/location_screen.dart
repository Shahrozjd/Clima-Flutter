import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:http/http.dart';
import 'city_screen.dart';


class LocationScreen extends StatefulWidget {

  var locationweather;

  @override
  _LocationScreenState createState() => _LocationScreenState();

  LocationScreen(this.locationweather);
}
class _LocationScreenState extends State<LocationScreen> {

  String weathercondition = "";
  int temp;
  String gettingmessage;
  String city;
  WeatherModel weatherModel = new WeatherModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UpdateUI(widget.locationweather);
  }

  void UpdateUI(dynamic datajson)
  {
    setState(() {
      if (datajson == null) {
        weathercondition = "ERROR";
        temp=0;
        gettingmessage="Cant get weather data";
        city = "";
      }
      else{
        // getting weather condiion
        var id = datajson["weather"][0]['id'];
        weathercondition = weatherModel.getWeatherIcon(id);

        //getting temprature
        double temprature = datajson['main']['temp'];
        temp = temprature.toInt();
        gettingmessage = weatherModel.getMessage(temp);

        //getting city name
        city = datajson['name'];
        print(id);
        print(temp);
        print(city);
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var locationweather = await weatherModel.getlocationweather();
                      UpdateUI(locationweather);

                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                     var getcityname = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));

                      if(getcityname != null)
                        {
                          var weatherdata = await weatherModel.getcityweather(getcityname);
                          UpdateUI(weatherdata);
                        }
                     },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weathercondition,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  gettingmessage+" in "+city,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


