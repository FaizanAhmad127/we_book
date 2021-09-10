import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_book/Models/ShopDetails/FirebaseRetrieveShopDetails.dart';
import 'package:we_book/Models/UserProfileDetails/RetrieveProfileData.dart';
import 'package:we_book/Services/LocationService.dart';

class PreloadProfileData {
  SharedPreferences sharedPreferences;
  RetrieveProfileData retrieveProfileDataClassObject;
  FirebaseRetrieveShopDetails firebaseRetrieveShopDetails;

  Future getReadyProfileData() async {
    var firebaseAuth = FirebaseAuth.instance;
    sharedPreferences = await SharedPreferences.getInstance();

    var uid = firebaseAuth.currentUser.uid;
    if (uid != null) {
      var userCategory = sharedPreferences.getString("userCategory");
      print("user category is $userCategory and uid is $uid");

      retrieveProfileDataClassObject =
          RetrieveProfileData(userCategory: userCategory, uid: uid);

      await retrieveProfileDataClassObject
          .getProfileData()
          .then((value) => retrieveProfileDataClassObject.getPictureURL());
          
      if (userCategory == "Book Seller") {
        firebaseRetrieveShopDetails = FirebaseRetrieveShopDetails(uid: uid);
        await firebaseRetrieveShopDetails
            .getProfileData()
            .then((value) => firebaseRetrieveShopDetails.getPictureURL());
      }
    } else {
      print("there's no current user, uid is null");
    }
  }
}
