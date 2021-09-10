import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_database/firebase_database.dart';

class UploadProfileData {
  var firebaseDatabaseReference = FirebaseDatabase().reference();
  String userCategory, uid;
  UploadProfileData({
    this.userCategory,
    this.uid,
  });

  Future<String> insertDataToDatabase(
      {String fullName = "Full Name",
      String emailAddress = "Enter email address..",
      String physicalAddress = "Enter you address..",
      String city = "Enter your city name",
      String country = "Enter your country name",
      String phoneNumber = "Enter your phone number"}) async {
    String status = "";
    await firebaseDatabaseReference
        .child("$userCategory/$uid/Profile Details")
        .update({
      "fullName": fullName,
      "emailAddress": emailAddress,
      "physicalAddress": physicalAddress,
      "city": city,
      "country": country,
      "phoneNumber": phoneNumber,
    }).whenComplete(() {
      print("user data is saved");
      status = "Success";
    }).catchError((Object error) {
      print("user Data not saved/Error");
      status = "Failure";
    });
    print("UploadProfileData.dart");
    return status;
  }

  Future updatePictureURL({String url}) async {
    await firebaseDatabaseReference
        .child("$userCategory/$uid/Profile Details")
        .update({
      "profilePicture": url,
    }).whenComplete(() {
      BotToast.showText(text: "Picture Saved");
    }).catchError((Object error) {
      BotToast.showText(text: "Picture not saved/Error");
    });
  }
}
