import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class Location
{
  double Longitude;
  double Latitude;

  Future<void> getcurrentlocation() async
  {
    try {
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      Longitude = position.longitude;
      Latitude = position.latitude;
    }
    catch(e)
    {
      print(e);
    }
  }
}