import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:we_book/Models/PictureManagement/UploadDownloadImage.dart';

class Book {
  var databaseReference = FirebaseDatabase().reference();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UploadDownloadImage uploadDownloadImage = UploadDownloadImage();
  String uid;

  Book() {
    uid = firebaseAuth.currentUser.uid;
  }

  Future<String> checkInBook({
    String bookName,
    String authorName,
    int bookEdition,
    int initialBookPrice,
    int finalBookPrice,
    int bookQuantity,
    String bookShelf,
    String editBookKey,
  }) async {
    DatabaseReference reference;
    String status;

    BotToast.showLoading();

    if (editBookKey == null) {
      reference = databaseReference.child("Book Seller/$uid/Books").push();
    } else {
      reference = //use when checkin is called from BSBookEdit.dart to edit the book
          databaseReference.child("Book Seller/$uid/Books/$editBookKey");
    }

    await reference.update({
      "bookName": bookName,
      "authorName": authorName,
      "bookEdition": bookEdition,
      "initialBookPrice": initialBookPrice,
      "finalBookPrice": finalBookPrice,
      "bookQuantity": bookQuantity,
      "bookShelf": bookShelf,
    }).whenComplete(() {
      editBookKey == null ? status = reference.key : status = editBookKey;
    }).catchError((error) {
      BotToast.showText(text: "Unable to upload data Book.dart");
      print("error at books.dart $error");
      editBookKey == null ? status = "Failure" : status = editBookKey;
      BotToast.closeAllLoading();
    });
    BotToast.closeAllLoading();
    return status;
  }

  Future<String> deleteBook(String key) async {
    String status;
    BotToast.showLoading();
    await databaseReference
        .child("Book Seller/$uid/Books/$key")
        .remove()
        .whenComplete(() {
      status = "Success";
      BotToast.closeAllLoading();
    }).catchError((error) {
      status = "Failure";
      print("error at deleteBook Book.dart");
      BotToast.closeAllLoading();
    });

    return status;
  }

  Future<String> updateBookPictureURL(
      {String url, String uid, String bookPushKey}) async {
    String status;
    BotToast.showLoading();
    await databaseReference
        .child("Book Seller/$uid/Books/$bookPushKey")
        .update({
      "bookImage": url,
    }).whenComplete(() {
      BotToast.closeAllLoading();
      BotToast.showText(text: "Picture Saved");
      print("Book picture is saved book.dart");
      status = "Success";
    }).catchError((Object error) {
      BotToast.closeAllLoading();
      BotToast.showText(text: "Picture not saved/Error");
      print("error at updateBookPictureURL in book.dart");
      status = "Failure";
    });
    return status;
  }

  Future<String> deleteBookPictureFromFirebaseStorage(String key) async {
    String status =
        await uploadDownloadImage.deletePicture("Book Seller/$uid/Books/", key);
    return status;
  }

  Future<Map<String, dynamic>> getAllBooksOfSeller() async {
    try {
      DataSnapshot snapshot =
          await databaseReference.child("Book Seller/$uid/Books").once();
      Map<String, dynamic> booksMap = Map.from(snapshot.value);
      return booksMap;
    } catch (error) {
      return Map();
    }
  }

  Future<String> checkoutBook(
      {String key, int initialQuantity, int finalQuantity}) async {
    BotToast.showLoading();

    String status = "Failure";
    if (finalQuantity <= initialQuantity) {
      int bookQuantity = initialQuantity - finalQuantity;
      await databaseReference.child("Book Seller/$uid/Books/$key").update({
        "bookQuantity": bookQuantity,
      }).whenComplete(() {
        status = "Success";
        BotToast.closeAllLoading();
      }).catchError((Object error) {
        status = "Failure";
        BotToast.closeAllLoading();
      });
    } else {
      status = "Failure ";
      BotToast.showText(
          text: "Not enough books in stock, Try agian!",
          duration: Duration(seconds: 5));
      BotToast.closeAllLoading();
    }
    return status;
  }

  Future getParentKeyOfBook({String uid, String bookName}) async {
    String status = "The book doesn't exist";
    List<String> bookKeysList = [];
    DataSnapshot snapshot =
        await databaseReference.child("Book Seller/$uid/Books").once();
    Map<String, dynamic> books = Map.from(snapshot.value);
    books.forEach((key, value) {
      if (value["bookName"].toString() == bookName) {
        bookKeysList.add(key);
      }
    });
    print(bookKeysList);
  }
}
