import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:we_book/Models/ShopDetails/FirebaseUploadShopDetails.dart';
import 'package:we_book/Models/UserProfileDetails/UploadProfileData.dart';

class FirebaseGoogleSignIn {
  final googleSignIn = GoogleSignIn();
  final firebaseAuth = FirebaseAuth.instance;
  UserCredential userCredential;
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  Future<String> signIn({String userCategory}) async {
    String status;
    try {
      googleSignIn.signOut();
      GoogleSignInAccount googleSignInAccount;
      googleSignInAccount = await googleSignIn.signIn();

      BotToast.showLoading();
      if (googleSignInAccount != null) {
        //check if book buyer and seller are already registered.
        bool bookBuyerEmail =
            await isBookBuyerEmail(email: googleSignInAccount.email);
        bool bookSellerEmail =
            await isBookSellerEmail(email: googleSignInAccount.email);
        //check whether user want to register as book buyer but the email is already registered with book seller
        if (userCategory == "Book Buyer" && bookSellerEmail) {
          await FirebaseAuth.instance.signOut().whenComplete(() async {
            await signOut().whenComplete(() {
              BotToast.showText(
                  text: "Email used for Book Seller Registration");
              BotToast.closeAllLoading();
              return "Failure";
            });
          });
        }
        //check whether user want to register as book seller but the email is already registered with book buyer
        else if (userCategory == "Book Seller" && bookBuyerEmail) {
          BotToast.showText(text: "Email used for Book Buyer Registration");
          await signOut().then((value) {
            firebaseAuth.signOut().whenComplete(() {
              BotToast.closeAllLoading();
              return "Failure";
            });
          });
        } else {
          final googleSignInAuthentication =
              await googleSignInAccount.authentication;

          final oAuthCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );
          userCredential = await firebaseAuth
              .signInWithCredential(oAuthCredential)
              .whenComplete(() {
            print("Successfully google signed in");
            status = "Success";
          }).catchError((e) {
            BotToast.closeAllLoading();
            status = "Failure";
            print("Error in FirebaseGoogleSignIn.dart $e");
          });

          if (status == "Success") {
            //if user is book buyer and the email is not registered as book buyer then we
            // need to register plus insert data into the database and vise versa for book seller
            if (userCategory == "Book Buyer" && bookBuyerEmail == false) {
              status = await populateDatabase(
                  userCategory: userCategory, userCredential: userCredential);
            }
            if (userCategory == "Book Seller" && bookSellerEmail == false) {
              status = await populateDatabase(
                  userCategory: userCategory, userCredential: userCredential);
            }
          }
        }
      } else if (googleSignInAccount == null) {
        BotToast.showText(text: "UnAble to Sign in with Google");
        BotToast.closeAllLoading();
        return "Failure";
      }
    } catch (e) {
      print("Exception in FirebaseGoogleSignIn.dart $e");
      BotToast.closeAllLoading();
      return "Failure";
    }
    BotToast.closeAllLoading();
    return status;
  }

//
// signing out
//
  Future signOut() async {
    BotToast.showLoading();
    try {
      if (firebaseAuth.currentUser != null) {
        await googleSignIn.disconnect().then((value) {
          googleSignIn.signOut();
        });
      }
    } catch (e) {
      BotToast.closeAllLoading();
      print(e.toString());
    }
    BotToast.closeAllLoading();
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

  Future<bool> isBookBuyerEmail({String email}) async {
    DataSnapshot snapshot =
        await databaseReference.child("User Emails/Book Buyer").once();
    return snapshot.value.toString().contains(email);
  }

  Future<bool> isBookSellerEmail({String email}) async {
    DataSnapshot snapshot =
        await databaseReference.child("User Emails/Book Seller").once();
    return snapshot.value.toString().contains(email);
  }
}
