import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:we_book/Models/RetrieveProfileData.dart';

class UploadProfileData {
  var firebaseDatabaseReference = FirebaseDatabase().reference();
  String userCategory, uid;
  UploadProfileData({
    this.userCategory,
    this.uid,
  });

  Future insertDataToDatabase(
      {String fullName,
      String emailAddress,
      String physicalAddress,
      String city,
      String country,
      String phoneNumber}) async {
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
      BotToast.showText(text: "Data Saved");
    }).catchError((Object error) {
      BotToast.showText(text: "Data not saved/Error");
    });
    print("UploadProfileData.dart");
    await RetrieveProfileData(userCategory: userCategory, uid: uid)
        .getProfileData();
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
