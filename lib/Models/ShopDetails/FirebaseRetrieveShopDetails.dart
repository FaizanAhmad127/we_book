import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_database/firebase_database.dart';
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
}
