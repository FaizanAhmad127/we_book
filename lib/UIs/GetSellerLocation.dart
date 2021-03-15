import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:we_book/UIs/PurpleRoundedButton.dart';

import '../constants.dart';

class GetSellerLocation extends StatefulWidget {
  @override
  _GetSellerLocationState createState() => _GetSellerLocationState();
}

class _GetSellerLocationState extends State<GetSellerLocation> {
  Location _locationTracker = Location();
  static double latitude = 34.0060495, longitude = 71.5179581;
  bool isCameraMoving = false;
  double currentLatitude, currentLongitude;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loc();
  }

  void loc() async {
    LocationData location = await _locationTracker.getLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    currentLatitude = latitude;
    currentLongitude = longitude;
    setState(() {});
  }

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(latitude, longitude),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialLocation,
            onCameraMove: (cameraPosition) {
              currentLongitude = cameraPosition.target.longitude;
              currentLatitude = cameraPosition.target.latitude;
              print(MediaQuery.of(context).size.height / 2);
              setState(() {
                isCameraMoving = true;
              });
            },
            onCameraIdle: () {
              setState(() {
                isCameraMoving = false;
              });
            },
          ),
          Align(
            alignment: Alignment.center,
            child: isCameraMoving
                ? IconButton(
                    iconSize: 30,
                    icon: Icon(
                      Icons.place,
                      color: Colors.red,
                    ),
                    onPressed: () {},
                  )
                : IconButton(
                    iconSize: 20,
                    icon: Icon(
                      FontAwesomeIcons.dotCircle,
                      color: Colors.green,
                    )),
          ),
          Positioned(
              bottom: MediaQuery.of(context).size.height * 0.02,
              right: MediaQuery.of(context).size.width * 0.25,
              left: MediaQuery.of(context).size.width * 0.25,
              child: PurpleRoundButton(
                buttonText: "SAVE LOCATION",
                buttonHeight: 0.08,
                buttonWidth: 0.3,
                onPressed: () {},
              )),
          Positioned(
              top: 20,
              height: MediaQuery.of(context).size.height * 0.05,
              left: MediaQuery.of(context).size.width / 10,
              right: MediaQuery.of(context).size.width / 10,
              child: Container(
                child: Center(
                  child: AutoSizeText(
                    "Lattitude: $currentLatitude | Longitude: $currentLongitude",
                    minFontSize: 6,
                    maxFontSize: 14,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: purpleColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              )),
        ],
      ),
    ));
  }
}
