import 'package:flutter/foundation.dart';

class BBBottomNavBarCN with ChangeNotifier {
  bool homeScreen = true;
  bool profileScreen = false;
  bool myQRCodesScreen = false;

  bool get getHomeScreen => homeScreen;
  bool get getProfileScreen => profileScreen;
  bool get getMyQRCodesScreen => myQRCodesScreen;
  set setHomeScreen(bool a) {
    homeScreen = a;
    if (a == true) {
      profileScreen = false;
      myQRCodesScreen = false;
    }
    notifyListeners();
  }

  set setProfileScreen(bool a) {
    profileScreen = a;
    if (a == true) {
      homeScreen = false;
      myQRCodesScreen = false;
    }
    notifyListeners();
  }

  set setMyQRCodesScreen(bool a) {
    myQRCodesScreen = a;
    if (a == true) {
      profileScreen = false;
      homeScreen = false;
    }
    notifyListeners();
  }
}
