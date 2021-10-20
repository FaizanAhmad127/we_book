import 'package:flutter/material.dart';

class BSCheckOutCN extends ChangeNotifier {
  int subTotal = 0;
  int discount = 0;
  int quantity = 1;
  int total = 0;
  Map<String, dynamic> bookKeysToCheckOutMap = {};

  int get getQuantity => quantity;
  int get getSubTotal => subTotal;
  int get getDiscount => discount;
  int get getTotal => total;
  Map<String, dynamic> get getBookKeysToCheckOutMap => bookKeysToCheckOutMap;

  set setQuanity(int a) {
    quantity = a;
    notifyListeners();
  }

  set setSubTotal(int price) {
    subTotal = subTotal + price;
    notifyListeners();
  }

  set setDiscount(int price) {
    discount = ((price / 100) * 5).toInt();
    total = price - discount;
    notifyListeners();
  }

  set setBooKKeysToCheckOutMap(Map<String, dynamic> bookKeysMap) {
    bookKeysToCheckOutMap.addAll(bookKeysMap);
  }
}
