import 'package:flutter/material.dart';

class BSCheckOutCN extends ChangeNotifier {
  int quantity = 1;

  int get getQuantity => quantity;

  set setQuanity(int a) {
    quantity = a;
    notifyListeners();
  }
}
