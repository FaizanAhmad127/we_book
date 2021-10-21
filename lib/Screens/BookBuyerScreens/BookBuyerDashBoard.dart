import 'dart:async';
import 'dart:typed_data';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:we_book/Models/ShopDetails/FirebaseRetrieveShopDetails.dart';
import 'package:we_book/Provider%20ChangeNotifiers/OpenPopUpBookCN.dart';
import 'package:we_book/Provider%20ChangeNotifiers/OpenQRCodeScreenCN.dart';
import 'package:we_book/UIs/GoogleMapsUI.dart';
import 'package:we_book/UIs/QRCodeUI.dart';
import 'package:we_book/constants.dart';
import 'package:we_book/UIs/BookPopUpUI.dart';
import 'package:provider/provider.dart';

class BookBuyerDashBoard extends StatefulWidget {
  @override
  _BookBuyerDashBoardState createState() => _BookBuyerDashBoardState();
}

class _BookBuyerDashBoardState extends State<BookBuyerDashBoard> {
  String bookName;
  FirebaseRetrieveShopDetails firebaseRetrieveShopDetails;
  FirebaseAuth firebaseAuth;
  String uid;

  List<Map<String, dynamic>> booksDataMap = [];
  bool showPopUp = false;
  Set<Marker> myMarkers = {};


@override
  void dispose() {
    super.dispose();
    BotToast.closeAllLoading();
  }
  @override
  void initState() {
    super.initState();
    firebaseAuth = FirebaseAuth.instance;
    uid = firebaseAuth.currentUser.uid;
    firebaseRetrieveShopDetails = FirebaseRetrieveShopDetails(uid: uid);
  }

  

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OpenQRCodeScreenCN(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => OpenPopUpBookCN(),
          lazy: false,
        ),
      ],
      child: GoogleMapsUI(
        bookMarkers: myMarkers,
        mySearchFieldAndButton: Positioned(
          top: screenHeight * 0.03,
          left: screenWidth * 0.02,
          right: screenWidth * 0.02,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  // width: MediaQuery.of(context).size.width * 0.63,
                  height: screenHeight * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey,
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {
                      bookName = value;
                    },
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
                width: screenWidth * 0.02,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: screenHeight * 0.06,
                  // width: MediaQuery.of(context).size.width * 0.3,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(3),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                      backgroundColor: MaterialStateProperty.all(purpleColor),
                    ),
                    onPressed: () async {
                      setState(() {
                        myMarkers.clear();
                      });

                      if (bookName != null && bookName != "") {
                        await firebaseRetrieveShopDetails
                            .getLocationsOfShops(bookName: bookName)
                            .then((bookSellerLoc) {
                          getMarker().then((markr) {
                            updateMarker(bookSellerLoc, markr);
                          });
                        });
                      }
                    },
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
            //showPopUp will be true using provider in BookPopUpUI.dart
            showPopUp = false;
            return Positioned(
              top: 10,
              bottom: 20,
              right: 20,
              left: 20,
              child: BookPopUpUI(booksDataMap: booksDataMap), //_controller),
            );
          } else {
            return Container();
          }
        }),
        myQRCode: Consumer<OpenQRCodeScreenCN>(
            builder: (context, openQRCodeScreen, _) {
          return openQRCodeScreen.qrStatus == true
              ? Positioned(
                  top: 20, bottom: 20, right: 20, left: 20, child: QRCodeUI())
              : Container();
        }),
      ),
    );
  }

  Future updateMarker(List<Map<String, dynamic>> bookSellerLocations,
      Uint8List imageData) async {
   
    if (bookSellerLocations.isNotEmpty) {
      bookSellerLocations.forEach((element) {
        String bookSellerKey;
        Map<String, dynamic> bookMap;
        String shopName;
        String shopAddress;
        String shopPhoneNumber;
        int editionCount;

        element.forEach((key, value) {
          if (key == "bookSellerKey") {
            bookSellerKey = value;
          }
          if (key == "bookMap") {
            editionCount = Map.from(value).length;
            bookMap = Map.from(value);
          }
          if (key == "shopName") {
            shopName = value;
          }
          if (key == "shopAddress") {
            shopAddress = value;
          }
          if (key == "shopPhoneNumber") {
            shopPhoneNumber = value;
          }

          if (key == "latlng") {
            myMarkers.add(Marker(
              markerId: MarkerId("bookicon $bookSellerKey"),
              position: LatLng(value.latitude, value.longitude),
              rotation: 0,
              draggable: false,
              zIndex: 2,
              flat: true,
              infoWindow: InfoWindow(
                  onTap: () {
                    booksDataMap.clear();
                    populateBooksMapData(
                        bookMap: bookMap,
                        bookSellerKey: bookSellerKey,
                        shopName: shopName,
                        shopAddress: shopAddress,
                        shopPhoneNumber: shopPhoneNumber);
                    setState(() {
                      showPopUp = true;
                    });
                  },
                  title: "$editionCount edition found",
                  snippet: "Tap me to find more"),
              anchor: Offset(0.5, 0.5),
              icon: BitmapDescriptor.fromBytes(imageData),
            ));
          }
        });
      });
    } else {
      BotToast.showText(text: "No book found", duration: Duration(seconds: 3));
    }
    setState(() {});
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("images/bookicon.png");
    return byteData.buffer.asUint8List();
  }

  void populateBooksMapData(
      {String bookSellerKey,
      Map<String, dynamic> bookMap,
      String shopName,
      shopAddress,
      shopPhoneNumber}) {
    bookMap.forEach((bookKey, value) {
      String qrCodeKey, bookName2, bookImage, authorName;
      qrCodeKey = bookSellerKey + " " +uid+" "+ bookKey;

      int bookEdition, finalBookPrice;
      Map.from(value).forEach((key, value) {
        if (key == "bookImage") {
          bookImage = value;
        }
        if (key == "bookName") {
          bookName2 = value;
        }
        if (key == "bookEdition") {
          bookEdition = value;
        }
        if (key == "authorName") {
          authorName = value;
        }
        if (key == "finalBookPrice") {
          finalBookPrice = value;
        }
      });
      booksDataMap.add({
        "qrCodeKey": qrCodeKey,
        "bookSellerKey": bookSellerKey,
        "bookKey":bookKey,
        "shopName": shopName,
        "shopAddress": shopAddress,
        "shopPhoneNumber": shopPhoneNumber,
        "bookImage": bookImage,
        "bookName": bookName2,
        "bookEdition": bookEdition,
        "authorName": authorName,
        "finalBookPrice": finalBookPrice,
      });
    });

    // print("booksDataMap is $booksDataMap");
  }
}
