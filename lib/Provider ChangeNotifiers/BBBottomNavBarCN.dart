import 'package:flutter/foundation.dart';

class BBBottomNavBarCN with ChangeNotifier {
  bool homeScreen = true;
  bool profileScreen = false;

  bool get getHomeScreen => homeScreen;
  bool get getProfileScreen => profileScreen;
  set setHomeScreen(bool a) {
    homeScreen = a;
    if (a == true) {
      profileScreen = false;
    }
    notifyListeners();
  }

  set setProfileScreen(bool a) {
    profileScreen = a;
    if (a == true) {
      homeScreen = false;
    }
    notifyListeners();
  }
}
