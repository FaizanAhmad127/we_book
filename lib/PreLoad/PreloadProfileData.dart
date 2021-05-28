import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_book/Models/RetrieveProfileData.dart';
import 'package:we_book/Services/LocationService.dart';

class PreloadProfileData {
  SharedPreferences sharedPreferences;
  RetrieveProfileData retrieveProfileDataClassObject;

  Future getReadyProfileData() async {
    var firebaseAuth = FirebaseAuth.instance;
    sharedPreferences = await SharedPreferences.getInstance();

    var uid = firebaseAuth.currentUser.uid;
    var userCategory = sharedPreferences.getString("userCategory");
    print("user category is $userCategory and uid is $uid");

    retrieveProfileDataClassObject =
        RetrieveProfileData(userCategory: userCategory, uid: uid);
    await retrieveProfileDataClassObject.getProfileData();
    await retrieveProfileDataClassObject.getPictureURL();
  }
}
