import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_book/Models/UserProfileDetails/UploadProfileData.dart';

import '../ShopDetails/FirebaseUploadShopDetails.dart';

class FirebaseEmailPasswordSignup {
  UserCredential userCredential;
  UploadProfileData uploadProfileData;

  Future<String> registration(
      {String fullName,
      String phoneNumber,
      String email,
      String password,
      String shopName,
      String shopAddress,
      String userCategory}) async {
    BotToast.showLoading();
    String status = "";
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        BotToast.showText(
            text: 'The password provided is too weak.',
            duration: Duration(seconds: 5));
      } else if (e.code == 'email-already-in-use') {
        BotToast.showText(
            text: 'The account already exists for that email.',
            duration: Duration(seconds: 5));
      }
      status = "Failure";
    } catch (e) {
      print(e);
      status = "Failure";
    }
    uploadProfileData = UploadProfileData(
        userCategory: userCategory, uid: userCredential.user.uid);
    status = await uploadProfileData.insertDataToDatabase(
        fullName: fullName, phoneNumber: phoneNumber, emailAddress: email);
    if (userCategory == "Book Seller") {
      status = await FirebaseUploadShopDetails(uid: userCredential.user.uid)
          .insertShopDetails(shopName: shopName, shopAddress: shopAddress);
    }
    BotToast.closeAllLoading();
    return status;
  }
}
