import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:we_book/Models/UserProfileDetails/UploadProfileData.dart';

import '../ShopDetails/FirebaseUploadShopDetails.dart';

class FirebaseEmailPasswordSignup {
  UserCredential userCredential;
  UploadProfileData uploadProfileData;
  DatabaseReference databaseReference;

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
      BotToast.closeAllLoading();
      return "Failure";
    } catch (e) {
      print(e);
      BotToast.closeAllLoading();
      return "Failure";
    }
    uploadProfileData = UploadProfileData(
        userCategory: userCategory, uid: userCredential.user.uid);
    status = await uploadProfileData.insertDataToDatabase(
        fullName: fullName, phoneNumber: phoneNumber, emailAddress: email);

    if (status != "Failure") {
      //to save the only email in separate node. it will help us during login to differentiate between type of users
      databaseReference = FirebaseDatabase.instance.reference();
      databaseReference
          .child("User Emails/$userCategory")
          .update({userCredential.user.uid: email});

      if (userCategory == "Book Seller") {
        status = await FirebaseUploadShopDetails(uid: userCredential.user.uid)
            .insertShopDetails(shopName: shopName, shopAddress: shopAddress);
      }
    }
    BotToast.closeAllLoading();
    return status;
  }
}
