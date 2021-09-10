import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Location location;
  double lattitude, longitude;
  LocationData locationData;
  LocationService() {
    location = Location();
  }

  Future<LocationData> getCurrentLocation() async {
    try {
      if (await checkLocationPermissions() == "Success") {
        locationData = await location.getLocation();
        return locationData;
      }
    } catch (e) {
      BotToast.showSimpleNotification(
          title: "Location error, LocationService.dart $e",
          duration: Duration(seconds: 5),
          backgroundColor: Colors.green);
    }
  }

  Future<String> checkLocationPermissions() async {
    try {
      if (await Permission.location.isGranted == true) {
        if (await location.serviceEnabled() == true) {
          return "Success";
        } else {
          BotToast.showText(text: "Please turn ON the GPS");
          await location.requestService();
          return "Failure";
        }
      } else {
        BotToast.showText(text: "Location permission is not granted");
        await Permission.location.request();
        return "Failure";
      }
    } catch (e) {
      BotToast.showText(text: "LocationService.dart $e");
      return "Failure";
    }
  }
}
