import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:delivery_project_app/widgets/show_custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationServices {
  // late BuildContext context;

  //Listen to location updates
  static void liveLocation(lat, long) {
    LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 100);

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((position) {
      lat = position.latitude;
      long = position.longitude;
    });
  }

  static void openLocationSetting() async {
    if (Platform.isAndroid) {
      AndroidIntent intent = const AndroidIntent(
        action: 'android.settings.LOCATION_SOURCE_SETTINGS',
      );
      await intent.launch();
    }
  }

  static Future<Position> getCurrentLocation(context) async {
    await Geolocator.isLocationServiceEnabled().then((value) {
      if (!value) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => CustomErrorDialog(
                  title: 'Location Service',
                  description: 'Please turn on location services',
                  onPressed: () {
                    openLocationSetting();
                    Navigator.pop(context);
                  },
                ));

        return Future.error('Location services are disabled.');
      }
    });

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request.');
    }
    return await Geolocator.getCurrentPosition();
  }
}
