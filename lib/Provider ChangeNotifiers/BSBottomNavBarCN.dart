import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

class BSBottomNavBarCN with ChangeNotifier {
  bool homeScreen = true;
  bool profileScreen = false;
  bool shopScreen = false;
  bool transactionScreen = false;

  bool get getHomeScreen => homeScreen;
  bool get getProfileScreen => profileScreen;
  bool get getShopScreen => shopScreen;
  bool get getTransactionScreen => transactionScreen;
  set setHomeScreen(bool a) {
    homeScreen = a;
    if (a == true) {
      profileScreen = false;
      shopScreen = false;
      transactionScreen = false;
    }
    notifyListeners();
  }

  set setProfileScreen(bool a) {
    profileScreen = a;
    if (a == true) {
      homeScreen = false;
      shopScreen = false;
      transactionScreen = false;
    }
    notifyListeners();
  }

  set setShopScreen(bool a) {
    shopScreen = a;
    if (a == true) {
      homeScreen = false;
      profileScreen = false;
      transactionScreen = false;
    }
    notifyListeners();
  }

  set setTransactionScreen(bool a) {
    transactionScreen = a;
    if (a == true) {
      homeScreen = false;
      profileScreen = false;
      shopScreen = false;
    }
    notifyListeners();
  }
}
