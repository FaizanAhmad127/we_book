import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:we_book/Services/MyDateTime.dart';

class Transactions {
  var databaseReference = FirebaseDatabase().reference();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String uid;
  MyDateTime myDateTime;

  Transactions() {
    uid = firebaseAuth.currentUser.uid;
    myDateTime = MyDateTime();
  }

  Future<String> makeTransaction(
    Map<String, dynamic> booksDetailMap,
    String buyerName,
  ) async {
    BotToast.showLoading();
    MyDateTime myDateTime = MyDateTime();
    String status;
    DatabaseReference dr;
    int totalOfAllBooks = 0, totalProfitOfAllBooks = 0;

    booksDetailMap.forEach((bookKey, value) {
      totalOfAllBooks = totalOfAllBooks + value["total"];
      totalProfitOfAllBooks = totalProfitOfAllBooks + value["profit"];
    });

    dr = databaseReference.child(
        "Book Seller/$uid/Transactions/${(myDateTime.getDateTime().millisecondsSinceEpoch / 1000).round()}");

    await dr.update({
      "year": myDateTime.getCurrentYear(),
      "month": myDateTime.getCurrentMonth(),
      "day": myDateTime.getCurrentDay(),
      "hour": myDateTime.getCurrentHour12(),
      "minute": myDateTime.getCurrentMinute(),
      "amPm": myDateTime.getAmPm(),
      "books": booksDetailMap,
      "buyerName": buyerName,
      "total": totalOfAllBooks,
      "profit": totalProfitOfAllBooks,
    }).whenComplete(() {
      BotToast.closeAllLoading();
      status = "Success";
    }).catchError((error) {
      status = "Failure";
      BotToast.closeAllLoading();
      print("error in makeTransaction book.dart $error");
    });
    return status;
  }

  Future<Map<String, dynamic>> getAllTransactions() async {
    DataSnapshot dataSnapshot;
    dataSnapshot = await databaseReference
        .child("Book Seller/$uid/Transactions")
        .startAt("0")
        .orderByKey()
        .once()
        .catchError((onError) {
      print("Error at getAllTransactions Transactions.dart $onError");
    });
    Map<String, dynamic> transactions = Map.from(dataSnapshot.value);

    //let's sorted out the transaction in descending order so the new transaction gets on top of listview
    List<int> listOfTransactionKeys = [];
    //collecting all the transaction keys
    transactions.forEach((key, value) {
      int transactionKey = int.parse(key);
      listOfTransactionKeys.add(transactionKey);
    });
    
    //sort it, by default it is in ascending order
    listOfTransactionKeys.sort();
    //coverting to decending order
    listOfTransactionKeys = listOfTransactionKeys.reversed.toList();
    //now comapare the keys with whole key value pairs. using the decending keys we will retrieve decenting key value from map.
    Map<String, dynamic> sortedTransactions = {};
    listOfTransactionKeys.forEach((element) {
      transactions.forEach((key, value) {
        if (element.toString() == key) {
          sortedTransactions.addAll({key: value});
        }
      });
    });
    
    return sortedTransactions;
  }

  Future<int> todayProfit() async {
    BotToast.showLoading();
    int profit = 0;
    DataSnapshot snapshot;
    snapshot = await databaseReference
        .child("Book Seller/$uid/Transactions")
        .once()
        .catchError((onError) {
      BotToast.closeAllLoading();
      print("Error at todayProfit Transactions.dart");
    });
    Map<String, dynamic> transactions = Map.from(snapshot.value);
    transactions.forEach((key, value) {
      if (value["day"] == myDateTime.getCurrentDay() &&
          value["month"] == myDateTime.getCurrentMonth() &&
          value["year"] == myDateTime.getCurrentYear()) {
        print(value["profit"]);
        profit = profit + value["profit"];
      }
    });
    BotToast.closeAllLoading();

    return profit;
  }

  Future<int> monthProfit() async {
    BotToast.showLoading();
    int profit = 0;
    DataSnapshot snapshot;
    snapshot = await databaseReference
        .child("Book Seller/$uid/Transactions")
        .once()
        .catchError((onError) {
      BotToast.closeAllLoading();
      print("Error at monthProfit Transactions.dart");
    });
    Map<String, dynamic> transactions = Map.from(snapshot.value);
    transactions.forEach((key, value) {
      if (value["month"] == myDateTime.getCurrentMonth() &&
          value["year"] == myDateTime.getCurrentYear()) {
        print(value["profit"]);
        profit = profit + value["profit"];
      }
    });
    BotToast.closeAllLoading();

    return profit;
  }

  Future<int> yearProfit() async {
    BotToast.showLoading();
    int profit = 0;
    DataSnapshot snapshot;
    snapshot = await databaseReference
        .child("Book Seller/$uid/Transactions")
        .once()
        .catchError((onError) {
      BotToast.closeAllLoading();
      print("Error at monthProfit Transactions.dart");
    });
    Map<String, dynamic> transactions = Map.from(snapshot.value);
    transactions.forEach((key, value) {
      if (value["year"] == myDateTime.getCurrentYear()) {
        print(value["profit"]);
        profit = profit + value["profit"];
      }
    });
    BotToast.closeAllLoading();

    return profit;
  }
}
