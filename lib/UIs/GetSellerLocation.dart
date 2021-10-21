import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_book/Models/ShopDetails/FirebaseRetrieveShopDetails.dart';
import 'package:we_book/Models/ShopDetails/FirebaseUploadShopDetails.dart';
import 'package:we_book/UIs/PurpleRoundedButton.dart';

import '../constants.dart';

class GetSellerLocation extends StatefulWidget {
  @override
  _GetSellerLocationState createState() => _GetSellerLocationState();
}

class _GetSellerLocationState extends State<GetSellerLocation> {
  Location _locationTracker = Location();
  static double latitude = 34.0060495, longitude = 71.5179581;
  double shopLocationLattitude, shopLocationLongitude;
  bool isCameraMoving = false;
  double currentLatitude, currentLongitude;
  FirebaseUploadShopDetails firebaseUploadShopDetails;
  FirebaseRetrieveShopDetails firebaseRetrieveShopDetails;
  SharedPreferences sharedPreferences;
  Set<Marker> marker = {};
  Marker shopMarker;
  FirebaseAuth firebaseAuth;

  @override
  void dispose() {
    super.dispose();
    BotToast.closeAllLoading();
  }
  @override
  void initState() {
    super.initState();
    loc();
    getShopLocation();
    firebaseAuth = FirebaseAuth.instance;
    firebaseUploadShopDetails =
        FirebaseUploadShopDetails(uid: firebaseAuth.currentUser.uid);
    firebaseRetrieveShopDetails =
        FirebaseRetrieveShopDetails(uid: firebaseAuth.currentUser.uid);
  }

  void loc() async {
    LocationData location = await _locationTracker.getLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    currentLatitude = latitude;
    currentLongitude = longitude;
    setState(() {});
  }

  Future updateMarker(LocationData newLocalData) async {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    print("we are inside updateMarker and locationdata is $newLocalData");
    await DefaultAssetBundle.of(context)
        .load("images/bookicon.png")
        .then((byteData) {
      setState(() {
       
        shopMarker = Marker(
            markerId: MarkerId("myShop"),
            position: latlng,
            rotation: newLocalData.heading,
            draggable: false,
            zIndex: 2,
            flat: true,
            anchor: Offset(0.5, 0.5),
            icon: BitmapDescriptor.fromBytes(byteData.buffer.asUint8List()));
        marker.add(shopMarker);
      
      });
    });
  }

  void getShopLocation() async {
    BotToast.showLoading();
    sharedPreferences = await SharedPreferences.getInstance();
    await firebaseRetrieveShopDetails.getShopLocation().then((status) {
      print(status);
      if (status == "Success") {
        shopLocationLattitude = sharedPreferences.getDouble("lattitude");
        shopLocationLongitude = sharedPreferences.getDouble("longitude");
        print(
            "shopLat is $shopLocationLattitude and shoplong is $shopLocationLongitude");
      }
    }).then((value) {
      LocationData locationData 
      = LocationData.fromMap({
        "latitude": shopLocationLattitude,
        "longitude": shopLocationLongitude
      });

      updateMarker(locationData).whenComplete(() {
        BotToast.closeAllLoading();
      }).catchError((onError) {
        print(onError);
        BotToast.closeAllLoading();
      });
    });
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
            myLocationEnabled: true,
            initialCameraPosition: initialLocation,
            markers: Set.of((marker != null) ? marker : []),
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
                    onPressed: () {},
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
                onPressed: () async {
                  await firebaseUploadShopDetails
                      .insertShopLocation(
                          lattitude: currentLatitude,
                          longitude: currentLongitude)
                      .then((status) {
                    if (status == "Success") {
                      BotToast.showText(
                          text: "Location is updated",
                          duration: Duration(seconds: 3));
                    }
                  });
                  Navigator.pop(context);
                },
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
