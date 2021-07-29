import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:we_book/Models/ShopDetails/FirebaseUploadShopDetails.dart';
import 'package:we_book/Models/UserProfileDetails/UploadProfileData.dart';

// Integrate facebook sdk, documentation at
// https://facebook.meedu.app
// https://developers.facebook.com/docs/facebook-login/android/?locale=en
//where you can find keytool .. https://stackoverflow.com/questions/4830253/where-is-the-keytool-application
// a problem which might occur which is openssl is not recognized then go to this link https://stackoverflow.com/questions/11896304/openssl-is-not-recognized-as-an-internal-or-external-command
// type this in cmd   C:\Program Files\Java\jdk1.8.0_121\bin>keytool -exportcert -alias androiddebugkey -keystore ~/.android/debug.keystore | "C:\Program Files\Git\usr\bin\openssl.exe" sha1 -binary | "C:\Program Files\Git\usr\bin\openssl.exe" base64
// remember Generating a Release Key Hash Android apps must be digitally signed with a release key before you can upload them to the store.
//This class is not configured for web app.
// debug key has is   3ZLW/TAqPvR43Zh79ejFQDOdka8=
//release key is eKJJHinr+D3pnrXYFuIJnPbO7ag=
// if hash key issue then go to https://github.com/magus/react-native-facebook-login/issues/297
// in my case both hash keys didn't work and failed to get result from Facebook.instance.login() and the result status was failed, so i used my sha1 key and generated the base64 hash key http://tomeko.net/online_tools/hex_to_base64.php
//the key which worked is /Cy9+zDpCToO7wQjyDIl4Ok5xk8=
class FirebaseFacebookSignIn {
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  Future<String> signInWithFacebook({String userCategory}) async {
    // Trigger the sign-in flow

    // for more permissions https://developers.facebook.com/docs/permissions/reference
    final LoginResult result = await FacebookAuth.instance.login();
    print(result.status);
    if (result.status == LoginStatus.success) {
      BotToast.showLoading();
      // you are logged
      try {
        final AccessToken accessToken = result.accessToken;
        // Create a credential from the access token
        final facebookAuthCredential =
            FacebookAuthProvider.credential(accessToken.token);
        // Once signed in, return the UserCredential
        final userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
        print(userCredential.user.displayName);

        return await populateDatabase(
            userCategory: userCategory, userCredential: userCredential);
      } catch (e) {
        BotToast.showText(text: e.toString());
      }
      BotToast.closeAllLoading();
    } else {
      BotToast.showText(text: "Unable to Sign In FirebaseFacebookSignIn.dart");
      return "Failure";
    }
  }

  Future facebookSignOut() async {
    try {
      final AccessToken accessToken = await FacebookAuth.instance.accessToken;
      if (accessToken != null) {
        await FacebookAuth.instance.logOut();
      }
    } catch (e) {
      print(
          "Error in FirebaseFacebookSignIn.dar and the error description is $e");
    }
  }

  Future<String> populateDatabase(
      {String userCategory, UserCredential userCredential}) async {
    UploadProfileData uploadProfileData;
    var fullName = userCredential.user.displayName;
    var phoneNumber = userCredential.user.phoneNumber;
    var email = userCredential.user.email;
    var shopName = "ABC Shop";
    var shopAddress = "Street 123";
    fullName ??= "ABC";
    phoneNumber ??= "03021234567";
    email ??= "abc@gmail.com";

    String status;

    uploadProfileData = UploadProfileData(
        userCategory: userCategory, uid: userCredential.user.uid);
    status = await uploadProfileData.insertDataToDatabase(
        fullName: fullName, phoneNumber: phoneNumber, emailAddress: email);

    if (status != "Failure") {
      //to save the only email in separate node. it will help us during login to differentiate between type of users
      databaseReference
          .child("User Emails/$userCategory")
          .update({userCredential.user.uid: email});

      if (userCategory == "Book Seller") {
        status = await FirebaseUploadShopDetails(uid: userCredential.user.uid)
            .insertShopDetails(shopName: shopName, shopAddress: shopAddress);
      }
    }
    return status;
  }
}
