import 'package:firebase_auth/firebase_auth.dart';

class FirebaseEmailPasswordSignup {
  UserCredential userCredential;
  FirebaseEmailPasswordSignup();
  Future<String> registration(String email, String password) async {
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
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
}
