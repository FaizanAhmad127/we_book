import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RetrieveProfileData {
  SharedPreferences sharedPreferences;
  var firebaseDatabaseReference = FirebaseDatabase().reference();

  String fullName = "fullName",
      emailAddress = "abc@gmail.com",
      physicalAddress = "123 Street",
      city = "London",
      country = "England",
      phoneNumber = "12345678";
  String userCategory, uid;
  RetrieveProfileData({
    this.userCategory,
    this.uid,
  });
  Future getProfileData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    DataSnapshot snapshot = await firebaseDatabaseReference
        .child("$userCategory/$uid/Profile Details")
        .once();
    //try catch if nothing is in snapshot
    try {
      fullName = snapshot.value["fullName"];
      emailAddress = snapshot.value["emailAddress"];
      physicalAddress = snapshot.value["physicalAddress"];
      city = snapshot.value["city"];
      country = snapshot.value["country"];
      phoneNumber = snapshot.value["phoneNumber"];

      sharedPreferences.setString("fullName", fullName);
      sharedPreferences.setString("emailAddress", emailAddress);
      sharedPreferences.setString("physicalAddress", physicalAddress);
      sharedPreferences.setString("city", city);
      sharedPreferences.setString("country", country);
      sharedPreferences.setString("phoneNumber", phoneNumber);
      print("full name is $fullName at retrieve profile");
    } catch (e) {
      BotToast.closeAllLoading();
      print("Something wrong in RetrieveProfileData.dart $e");
      BotToast.showText(text: "Something wrong in RetrieveProfileData.dart $e");
    }
  }

  Future getPictureURL() async {
    sharedPreferences = await SharedPreferences.getInstance();
    DataSnapshot snapshot = await firebaseDatabaseReference
        .child("$userCategory/$uid/Profile Details/profilePicture")
        .once()
        .whenComplete(() {})
        .catchError((Object error) {
      print(error.toString());
    });
    if (snapshot.value == null) {
      sharedPreferences.setString("profilePictureURL", "nothing");
    } else {
      sharedPreferences.setString("profilePictureURL", snapshot.value);
    }
  }

  Future<String> getBookBuyerNameUsingUID(String uid) async {
    BotToast.showLoading();
    String fullName = "anonymous user";
    DataSnapshot snapshot = await firebaseDatabaseReference
        .child("Book Buyer/$uid/Profile Details")
        .once()
        .catchError((error) {
      print("error at getBookBuyerNameUsingUID and error is $error");
      BotToast.closeAllLoading();
    }).whenComplete(() {
      BotToast.closeAllLoading();
    });
    if (snapshot.value != null) {
      Map.from(snapshot.value).forEach((key, value) {
        if (key == "fullName") {
          fullName = value;
        }
      });
    }
    return fullName;
  }
}
