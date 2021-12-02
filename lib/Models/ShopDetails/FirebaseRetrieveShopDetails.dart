import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseRetrieveShopDetails {
  SharedPreferences sharedPreferences;
  var firebaseDatabaseReference = FirebaseDatabase().reference();

  String shopName = "shopName",
      shopAddress = "Shop 3, Saddar road",
      shopCity = "London",
      shopCountry = "England",
      shopPhoneNumber = "12345678";
  String uid;
  FirebaseRetrieveShopDetails({
    this.uid,
  });
  Future getProfileData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    DataSnapshot snapshot = await firebaseDatabaseReference
        .child("Book Seller/$uid/Shop Details")
        .once();
    //try catch if nothing is in snapshot
    try {
      shopName = snapshot.value["shopName"] == null
          ? shopName
          : snapshot.value["shopName"];
      shopAddress = snapshot.value["shopAddress"] == null
          ? shopAddress
          : snapshot.value["shopAddress"];
      shopCity = snapshot.value["shopCity"] == null
          ? shopCity
          : snapshot.value["shopCity"];
      shopCountry = snapshot.value["shopCountry"] == null
          ? shopCountry
          : snapshot.value["shopCountry"];
      shopPhoneNumber = snapshot.value["shopPhoneNumber"] == null
          ? shopPhoneNumber
          : snapshot.value["shopPhoneNumber"];

      sharedPreferences.setString("shopName", shopName);
      sharedPreferences.setString("shopAddress", shopAddress);
      sharedPreferences.setString("shopCity", shopCity);
      sharedPreferences.setString("shopCountry", shopCountry);
      sharedPreferences.setString("shopPhoneNumber", shopPhoneNumber);
    } catch (e) {
      print(
          "Something wrong in FirebaseRetrieveShopDetails.dart $e  values are $shopName $shopAddress $shopCity $shopCountry $shopPhoneNumber");
      BotToast.showText(
          text: "Something wrong in FirebaseRetrieveShopDetails.dart");
    }
  }

  Future getPictureURL() async {
    sharedPreferences = await SharedPreferences.getInstance();
    DataSnapshot snapshot = await firebaseDatabaseReference
        .child("Book Seller/$uid/Shop Details/shopPicture")
        .once()
        .whenComplete(() {})
        .catchError((Object error) {
      print(error.toString());
    });
    if (snapshot.value == null) {
      sharedPreferences.setString("shopPictureURL", "nothing");
    } else {
      sharedPreferences.setString("shopPictureURL", snapshot.value);
    }
  }

  Future<String> getShopLocation() async {
    String status;
    BotToast.showLoading();
    double lattitude, longitude;
    sharedPreferences = await SharedPreferences.getInstance();
    await firebaseDatabaseReference
        .child("Book Seller/$uid/Shop Details")
        .once()
        .then((snapshot) {
      if (snapshot.value["lattitude"] == null ||
          snapshot.value["longitude"] == null) {
        sharedPreferences.setDouble("lattitude", 34.0060495);
        sharedPreferences.setDouble("longitude", 71.5179581);
      } else {
        lattitude = snapshot.value["lattitude"];
        longitude = snapshot.value["longitude"];
        sharedPreferences.setDouble("lattitude", lattitude);
        sharedPreferences.setDouble("longitude", longitude);
      }
    }).whenComplete(() {
      status = "Success";
      BotToast.closeAllLoading();
    }).catchError((Object error) {
      print(error.toString());
      BotToast.closeAllLoading();
      status = "Failure";
    });

    return status;
  }

  Future<List<Map<String, dynamic>>> getLocationsOfShops(
      {String bookName}) async {
    BotToast.showLoading();
    List<Map<String, dynamic>> bookSellerLocations = [];

    await firebaseDatabaseReference
        .child("Book Seller")
        .once()
        .then((dataSnapshot) async {
      for (var b in Map.from(dataSnapshot.value).entries) {
        dynamic bookSellerKey = b.key;
        dynamic value = b.value;

        
        String authorName = "";
        String bookImage = "";
        int bookEdition;
        int finalBookPrice;
        String bookName2 = "";
        //print("Book seller uid is $bookSellerKey");

        //children of Book Seller
        for (var a in Map.from(value).entries) {
          //print("key is ${a.key}");
          Map<String, dynamic> bookMap = {};

          if (a.key == "Books") {
            //childrens of Books
            Map.from(a.value).forEach((bookKey, bookKeyValue) {
              bool isBookFound = false;
              String myBookKey = "";
              //children of specific book
              Map.from(bookKeyValue).forEach((key, value) {
               // print("key is $key");
                if (key == "authorName") {
                  authorName = value;
                }
                if (key == "bookEdition") {
                  bookEdition = value;
                }
                if (key == "bookImage") {
                  bookImage = value;
                }
                if (key == "bookName") {
                  bookName2 = value;
                }
                if (key == "finalBookPrice") {
                  finalBookPrice = value;
                }
                if (key == "bookName") {
                 
                  if (value
                      .toString()
                      .toLowerCase()==
                    (bookName.toLowerCase())) {
                    // print("yes this book is here and the bookKey is $bookKey");
                    isBookFound = true;
                    myBookKey = bookKey;
                    
                  }
                }
              });
             
              if(isBookFound==true)
              {
                   bookMap.addAll({
                myBookKey: {
                  "bookImage": bookImage,
                  "bookName": bookName2,
                  "bookEdition":bookEdition,
                  "authorName": authorName,
                  "finalBookPrice": finalBookPrice,
                }
              });
              }
              
            });
          }
         // print("bookMap  is $bookMap and ${bookMap.isNotEmpty}");

          if (bookMap.isNotEmpty) {
            //print("Fetching shop details");

            await firebaseDatabaseReference
                .child("Book Seller/$bookSellerKey/Shop Details")
                .once()
                .then((dataSnapshot) {
                  double latitude = 1, longitude = 1;
                  String shopName = "";
                  String shopAddress = "";
                  String shopPhoneNumber = "";
                  Map.from(dataSnapshot.value).forEach((key, value) {
                    if (key == "lattitude") {
                      latitude = value;
                    } if (key == "longitude") {
                      longitude = value;
                    } if (key == "shopName") {
                      shopName = value;
                    } if (key == "shopAddress") {
                      shopAddress = value;
                    } if (key == "shopPhoneNumber") {
                      shopPhoneNumber = value;
                    }
                  });
                  if (latitude != null && longitude != null) {
                    // print("lat is $latitude and longi is $longitude");
                    LatLng latLngg = LatLng(latitude, longitude);

                    bookSellerLocations.add({
                      "bookSellerKey": bookSellerKey,
                      "bookMap": bookMap,
                      "shopName": shopName,
                      "shopAddress": shopAddress,
                      "shopPhoneNumber": shopPhoneNumber,
                      "latlng": latLngg,
                    });
                  }
                })
                .whenComplete(() {})
                .catchError((error) {
                  print("getLocationOfShops $error");
                });
          }
        }
      }
    }).whenComplete(() {
      BotToast.closeAllLoading();
    }).catchError((error) {
      BotToast.closeAllLoading();
      print("error");
    });
    // print("about to return");
    return bookSellerLocations;
  }
}
