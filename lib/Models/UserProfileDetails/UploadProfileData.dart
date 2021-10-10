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
      {String fullName = "",
      String emailAddress = "",
      String physicalAddress = "",
      String city = "",
      String country = "",
      String phoneNumber = ""}) async {
    String status = "";

    BotToast.showLoading();
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
      BotToast.closeAllLoading();
    }).catchError((Object error) {
      print("user Data not saved/Error");
      status = "Failure";
      BotToast.closeAllLoading();
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
