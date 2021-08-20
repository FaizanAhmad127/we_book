import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Book {
  var databaseReference = FirebaseDatabase().reference();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<String> checkInBook(
      {String bookName,
      String authorName,
      String bookEdition,
      String initialBookPrice,
      String finalBookPrice,
      String bookQuantity,
      String bookShelf,
      String uid}) async {
    String status;
    uid = firebaseAuth.currentUser.uid;
    BotToast.showLoading();

    DatabaseReference reference =
        databaseReference.child("Book Seller/$uid/Books").push();

    await reference.update({
      "bookName": bookName,
      "authorName": authorName,
      "bookEdition": bookEdition,
      "initialBookPrice": initialBookPrice,
      "finalBookPrice": finalBookPrice,
      "bookQuantity": bookQuantity,
      "bookShelf": bookShelf,
    }).whenComplete(() {
      status = reference.key;
    }).catchError((error) {
      BotToast.showText(text: "Unable to upload data Book.dart");
      print("error at books.dart $error");
      status = "Failure";
      BotToast.closeAllLoading();
    });
    BotToast.closeAllLoading();
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
