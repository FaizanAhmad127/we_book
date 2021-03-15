import 'package:flutter/foundation.dart';

class BSBottomNavBarCN with ChangeNotifier {
  bool homeScreen = true;
  bool profileScreen = false;
  bool shopScreen = false;

  bool get getHomeScreen => homeScreen;
  bool get getProfileScreen => profileScreen;
  bool get getShopScreen => shopScreen;
  set setHomeScreen(bool a) {
    homeScreen = a;
    if (a == true) {
      profileScreen = false;
      shopScreen = false;
    }
    notifyListeners();
  }

  set setProfileScreen(bool a) {
    profileScreen = a;
    if (a == true) {
      homeScreen = false;
      shopScreen = false;
    }
    notifyListeners();
  }

  set setShopScreen(bool a) {
    shopScreen = a;
    if (a == true) {
      homeScreen = false;
      profileScreen = false;
    }
    notifyListeners();
  }
}
