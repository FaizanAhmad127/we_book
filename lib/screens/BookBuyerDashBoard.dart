import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:we_book/Provider%20ChangeNotifiers/OpenPopUpBookCN.dart';
import 'package:we_book/Provider%20ChangeNotifiers/OpenQRCodeScreen.dart';
import 'package:we_book/UIs/GoogleMapsUI.dart';
import 'package:location/location.dart';
import 'package:we_book/UIs/QRCodeUI.dart';
import 'package:we_book/constants.dart';
import 'package:we_book/UIs/BookPopUpUI.dart';
import 'package:provider/provider.dart';

class BookBuyerDashBoard extends StatefulWidget {
  @override
  _BookBuyerDashBoardState createState() => _BookBuyerDashBoardState();
}

class _BookBuyerDashBoardState extends State<BookBuyerDashBoard> {
  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  bool showPopUp = false;
  Set<Marker> myMarkers = {};
  List<double> lat = [
    34.0085425,
    34.008916,
    34.0081868,
    34.0052696,
    34.0048782,
    34.0006267
  ];
  List<double> long = [
    71.5072444,
    71.5134671,
    71.5203121,
    71.5182737,
    71.5280798,
    71.5363196
  ];
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OpenQRCodeScreen(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => OpenPopUpBookCN(),
          lazy: false,
        )
      ],
      child: GoogleMapsUI(
        bookMarkers: myMarkers,
        mySearchFieldAndButton: Positioned(
          top: MediaQuery.of(context).size.height * 0.03,
          left: MediaQuery.of(context).size.width * 0.02,
          right: MediaQuery.of(context).size.width * 0.02,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  // width: MediaQuery.of(context).size.width * 0.63,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey,
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        hintText: "Enter Book Name",
                        filled: true,
                        fillColor: Colors.transparent,
                        border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  // width: MediaQuery.of(context).size.width * 0.3,
                  child: RaisedButton(
                    elevation: 3,
                    onPressed: () {
                      bookMarker();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: purpleColor,
                    child: Text(
                      "SEARCH",
                      style: TextStyle(
                          color: Colors.white, fontFamily: "Source Sans Pro"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        myPopUp:
            Consumer<OpenPopUpBookCN>(builder: (context, openPopUpBookCN, _) {
          if (openPopUpBookCN.popUpStatus == true || showPopUp == true) {
            showPopUp = false;
            return Positioned(
              top: 10,
              bottom: 20,
              right: 20,
              left: 20,
              child: BookPopUpUI(), //_controller),
            );
          } else {
            return Container();
          }
        }),

        myQRCode:
            Consumer<OpenQRCodeScreen>(builder: (context, openQRCodeScreen, _) {
          return openQRCodeScreen.qrStatus == true
              ? Positioned(
                  top: 20, bottom: 20, right: 20, left: 20, child: QRCodeUI())
              : Container();
        }),
        // myQRCode: OpenQRCodeScreen.qrStatus == true
        //     ? Positioned(
        //         top: 20, bottom: 20, right: 20, left: 20, child: QRCodeUI())
        //     : Container(),
      ),
    );
  }

  void bookMarker() async {
    Location location = Location();
    var locationData = await location.getLocation();
    Uint8List imageData = await getMarker();
    updateMarker(locationData, imageData);
  }

  void updateMarker(LocationData locationData, Uint8List imageData) {
    var latlng = LatLng(locationData.latitude, locationData.longitude);

    for (int i = 0; i < lat.length; i++) {
      myMarkers.add(Marker(
        markerId: MarkerId("bookicon $i"),
        position: LatLng(lat[i], long[i]),
        rotation: 0,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(imageData),
        onTap: () {
          setState(() {
            showPopUp = true;
          });
        },
      ));
    }
    setState(() {});
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("images/bookicon.png");
    return byteData.buffer.asUint8List();
  }
}