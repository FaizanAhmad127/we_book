import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:bot_toast/bot_toast.dart';

class FirebaseGoogleSignIn {
  final googleSignIn = GoogleSignIn();
  final firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn() async {
    BotToast.showLoading();
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    BotToast.closeAllLoading();
    if (googleSignInAccount == null) {
      BotToast.showText(text: "UnAble to Sign in with Google");
      return "Failure";
    } else {
      BotToast.showLoading();
      final googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final oAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await firebaseAuth
          .signInWithCredential(oAuthCredential)
          .whenComplete(() {
            print("Successfully google signed in");
          })
          .catchError((e) => print("Error while google signin $e"))
          .then((userCredentials) => print(userCredentials.user.displayName));
      BotToast.closeAllLoading();

      return "Success";
    }
  }

  Future signOut() async {
    try {
      if (firebaseAuth.currentUser != null) {
        await googleSignIn.disconnect();
        await googleSignIn.signOut();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
