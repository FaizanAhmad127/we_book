import 'package:bot_toast/bot_toast.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseQr {
  var databaseReference = FirebaseDatabase().reference();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String uid;

  FirebaseQr() {
    uid = firebaseAuth.currentUser.uid;
  }

  Future<String> uploadQrCode(Map<String, dynamic> qrDataMap) async {
    BotToast.showLoading();
    String status;
    await databaseReference
        .child("Book Buyer/$uid/QR Codes/${qrDataMap["bookSellerKey"]}")
        .update({qrDataMap["qrCodeKey"]: qrDataMap["bookKey"]}).whenComplete(
            () {
      status = "Success";
      BotToast.closeAllLoading();
    }).catchError((error) {
      status = "Failure";
      print("error at uploadQrCode method at FirebaseQr.dart");
      BotToast.closeAllLoading();
    });
    return status;
  }

  Future retieveQrCode() async {
    List<Map<String, dynamic>> bookSellerQRCodes = [];
    DataSnapshot dataSnapshot1 = await databaseReference
        .child("Book Buyer/$uid/QR Codes")
        .once()
        .catchError((error) {
      print("error at retrieveQrCode at FirebaseQR.dart and eror is $error");
    });

    if (dataSnapshot1.value != null) {
      //children of QrCodes node which are list of book sellers
      for (var a in Map.from(dataSnapshot1.value).entries) {
        Map<String, dynamic> booksMap = {};
        String bookSellerKey = a.key;
        String qrKey = "$bookSellerKey $uid";
        String shopName = "";
        String shopPhoneNumber = "";
        String shopAddress = "";
        //fetching shop details of specific shop
        DataSnapshot dataSnapshot2 = await databaseReference
            .child("Book Seller/$bookSellerKey/Shop Details")
            .once()
            .catchError((error) {
          print(
              "error at retrieveQrCode at FirebaseQR.dart and eror is $error");
        });
        if (dataSnapshot2.value != null) {
          //children of shop details
          //Storing shop detials
          Map.from(dataSnapshot2.value).forEach((key, value) {
            if (key == "shopName") {
              shopName = value;
            }
            if (key == "shopPhoneNumber") {
              shopPhoneNumber = value;
            }
            if (key == "shopAddress") {
              shopAddress = value;
            }
          });
          //children of QrCodes/bookSellerkey which is qrkey:bookKey
          for (var b in Map.from(a.value).entries) {
            String bookKey = b.value, bookName = "", authorName = "";
            int bookEdition = 0, finalBookPrice = 0;
            DataSnapshot dataSnapshot3 = await databaseReference
                .child("Book Seller/$bookSellerKey/Books/$bookKey")
                .once()
                .catchError((error) {
              print(
                  "error at retrieveQrCode at FirebaseQR.dart and eror is $error");
            });
            if (dataSnapshot3.value != null) {
              //Storing book details
              Map.from(dataSnapshot3.value).forEach((key, value) {
                if (key == "bookName") {
                  bookName = value;
                }
                if (key == "authorName") {
                  authorName = value;
                }
                if (key == "bookEdition") {
                  bookEdition = value;
                }
                if (key == "finalBookPrice") {
                  finalBookPrice = value;
                }
              });
              booksMap.addAll({
                bookKey: {
                  "bookName": bookName,
                  "authorName": authorName,
                  "bookEdition": bookEdition,
                  "finalBookPrice": finalBookPrice,
                }
              });
            }
          }
        }
        bookSellerQRCodes.add({
          "bookSellerKey": bookSellerKey,
          "qrKey": qrKey,
          "bookMap": booksMap,
          "shopName": shopName,
          "shopAddress": shopAddress,
          "shopPhoneNumber": shopPhoneNumber,
        });
      }
    }
    return bookSellerQRCodes;
  }

  Future<List<String>> getListOfBookKeysFromQRCodes(
      String bookBuyerkey, String bookSellerKey) async {
    List<String> bookKeys = [];
    DataSnapshot snapshot = await databaseReference
        .child("Book Buyer/$bookBuyerkey/QR Codes/$bookSellerKey")
        .once()
        .catchError((error) {
      print("error at getListOfBookKeysFromQRCodes at FirebaseQR.dart $error");
    });
    if (snapshot.value != null) {
      Map.from(snapshot.value).forEach((key, value) {
        bookKeys.add(value);
      });
    }
    return bookKeys;
  }

  Future<String> deleteBookQR(String deleteQRKey) async {
    BotToast.showLoading();
    String status;
    List<String> s = deleteQRKey.split(" ");
    String bookSellerKey = s[0];
    await databaseReference
        .child("Book Buyer/$uid/QR Codes/$bookSellerKey/$deleteQRKey")
        .remove()
        .whenComplete(() {
      status = "Success";
      BotToast.closeAllLoading();
    }).catchError((error) {
      status = "Failure";
      print(
          "error at deleteBookQR method at FirebaseQR.dart and the error is $error");
      BotToast.closeAllLoading();
    });
    return status;
  }

  Future<String> deleteSellerQR(String bookSellerKey) async {
    BotToast.showLoading();
    String status;

    await databaseReference
        .child("Book Buyer/$uid/QR Codes/$bookSellerKey")
        .remove()
        .whenComplete(() {
      status = "Success";
      BotToast.closeAllLoading();
    }).catchError((error) {
      status = "Failure";
      print(
          "error at deleteSellerQR method at FirebaseQR.dart and the error is $error");
      BotToast.closeAllLoading();
    });
    return status;
  }
}
