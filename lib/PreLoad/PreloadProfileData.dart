import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_book/Models/RetrieveProfileData.dart';

class PreloadProfileData {
  SharedPreferences sharedPreferences;
  RetrieveProfileData retrieveProfileDataClassObject;

  void getReadyProfileData() async {
    var firebaseAuth = FirebaseAuth.instance;
    sharedPreferences = await SharedPreferences.getInstance();

    var uid = firebaseAuth.currentUser.uid;
    var userCategory = sharedPreferences.getString("userCategory");

    retrieveProfileDataClassObject =
        RetrieveProfileData(userCategory: userCategory, uid: uid);
    retrieveProfileDataClassObject.getProfileData();
    retrieveProfileDataClassObject.getPictureURL();
  }
}
