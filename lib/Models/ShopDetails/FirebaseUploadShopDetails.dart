import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseUploadShopDetails {
  var firebaseDatabaseReference = FirebaseDatabase().reference();
  String uid;
  FirebaseUploadShopDetails({
    this.uid,
  });

  Future<String> insertShopDetails(
      {String shopName = "Shop Name",
      String shopAddress = "Shop Address",
      String shopCity = "Shop City",
      String shopCountry = "Shop Country",
      String shopPhoneNumber = "03021234567"}) async {
    String status = "";
    await firebaseDatabaseReference
        .child("Book Seller/$uid/Shop Details")
        .update({
      "shopName": shopName,
      "shopAddress": shopAddress,
      "shopCity": shopCity,
      "shopCountry": shopCountry,
      "shopPhoneNumber": shopPhoneNumber
    }).whenComplete(() {
      status = "Success";
    }).catchError((Object error) {
      status = "Failure";
      print("error in FirebaseUploadShopDetails.dart");
    });
    return status;
  }

  Future<String> insertShopLocation(
      {double lattitude = 34.0060495, double longitude = 71.5179581}) async {
    BotToast.showLoading();
    String status = "";
    await firebaseDatabaseReference
        .child("Book Seller/$uid/Shop Details")
        .update({
      "lattitude": lattitude,
      "longitude": longitude,
    }).whenComplete(() {
      status = "Success";
      BotToast.closeAllLoading();
    }).catchError((Object error) {
      status = "Failure";
      print("error at insertShopLocation FirebaseUploadShopdetails.dart $error");
      BotToast.closeAllLoading();
    });
    return status;
  }

  Future updateShopPictureURL({String url}) async {
    await firebaseDatabaseReference
        .child("Book Seller/$uid/Shop Details")
        .update({
      "shopPicture": url,
    }).whenComplete(() {
      BotToast.showText(text: "Picture Saved");
    }).catchError((Object error) {
      BotToast.showText(text: "Picture not saved/Error");
    });
  }
}
