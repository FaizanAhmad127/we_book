import 'package:firebase_database/firebase_database.dart';

class Recommendation {
  DatabaseReference databaseReference;
  Recommendation() {
    databaseReference = FirebaseDatabase().reference();
  }

  Future<List<Map<String,String>>> suggestBooksToSellers() async {
    List<Map<String, dynamic>> listOfBookDetialsMap = [];

    DataSnapshot bookSellerSnapshot =
        await databaseReference.child("Book Seller").once();
    if (bookSellerSnapshot.value != null) {
      Map.from(bookSellerSnapshot.value).forEach((key, value) {
        String bookSellerKey = key;
        // print("book seller key is $bookSellerKey ");
        Map.from(value).forEach((key, value) {
          if (key == "Transactions") {
            Map.from(value).forEach((key, value) {
              String transactionKey = key;
              //print("transaction key is $transactionKey");
              Map.from(value).forEach((key, value) {
                if (key == "books") {
                  Map.from(value).forEach((key, value) {
                    String bookKey = key;
                    //print("book key is $bookKey and book details are $value");
                    listOfBookDetialsMap.add({
                      "bookSellerKey": bookSellerKey,
                      "transactionId": transactionKey,
                      "bookKey": bookKey,
                      "bookName": value["bookName"],
                      "quantity": value["quantity"],
                    });
                  });
                }
              });
            });
          }
        });
      });
    }

    List<Map<String, dynamic>> finalBookDetailsMap = [];
    while (listOfBookDetialsMap.length != 0) {
      Map<String, dynamic> firstElement = listOfBookDetialsMap.first;
      int j = 0;
      List<int> toRemoveIndices = [];
      listOfBookDetialsMap.forEach((element) {
        if (j == 0) {
        } else {
          if (firstElement["bookName"].toString().toLowerCase() ==
              element["bookName"].toString().toLowerCase()) {
            //increasing bookQuantity when book name is matched
            int previousCount = firstElement["quantity"];
            int newCount = element["quantity"];
            firstElement = {
              "bookSellerKey": firstElement["bookSellerKey"],
              "transactionId": firstElement["transactionId"],
              "bookKey": firstElement["bookKey"],
              "bookName": firstElement["bookName"],
              "quantity": previousCount + newCount,
            };
            //removing the second same book name found
            toRemoveIndices.add(j);
          }
        }
        j++;
      });
      int indexNO = 0;
      toRemoveIndices.forEach((index) {
        listOfBookDetialsMap.removeAt(index - indexNO);
        indexNO++;
      });
      //removing the first book as it is already compared to all other books
      listOfBookDetialsMap.removeAt(0);

      finalBookDetailsMap.add(firstElement);
    }
    //sorting from most sold books to least sold book
    finalBookDetailsMap.sort(
        (first, second) => second["quantity"].compareTo(first["quantity"]));

    if (finalBookDetailsMap.length > 10) {
      finalBookDetailsMap = finalBookDetailsMap.sublist(0, 10);
    }

    List<Map<String, String>> booksRecomendationData = [];
    finalBookDetailsMap.forEach((element) {
      if (bookSellerSnapshot.value != null) {
        Map.from(bookSellerSnapshot.value).forEach((key, value) {
          String bookSellerKey = key;
          if (bookSellerKey == element["bookSellerKey"]) {
            Map.from(value).forEach((key, value) {
              if (key == "Books") {
                Map.from(value).forEach((key, value) {
                  String bookKey = key;
                  if (bookKey == element["bookKey"]) {
                    booksRecomendationData.add({
                      "BookName": value["bookName"],
                      "BookAuthor": value["authorName"],
                      "Image": value["bookImage"]
                    });
                  }
                });
              }
            });
          }
        });
      }
    });

    return booksRecomendationData;
  }
}
