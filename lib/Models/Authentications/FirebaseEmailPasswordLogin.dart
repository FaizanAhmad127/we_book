import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class FirebaseEmailPasswordLogin {
  UserCredential userCredential;
  DatabaseReference databaseReference;
  Future<String> login(
      {String email = "", String password = "", String userCategory}) async {
    try {
      if (await isEmailAlreadySignedUp(
          userCategory: userCategory, email: email)) {
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } else {
        print("Email not registered");
        return "Failure";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return "Failure";
    } catch (e) {
      print(e);
      return "Failure";
    }

    return "Success";
  }

  Future<String> resetPassword(
      {@required String email, @required BuildContext context}) async {
    String result = "";
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .whenComplete(() => result = "Success");
    } catch (e) {
      BotToast.showText(text: "error in resetting password $e");
      result = "Failure";
    }
    return result;
  }

  Future<bool> isEmailAlreadySignedUp(
      {String userCategory, String email}) async {
    databaseReference = FirebaseDatabase.instance.reference();
    DataSnapshot snapshot =
        await databaseReference.child("User Emails/$userCategory").once();
    return snapshot.value.toString().contains(email);
  }
}
