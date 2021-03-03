import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class OpenPopUpBookCN with ChangeNotifier {
  bool openPopUp = false;

  bool get popUpStatus => openPopUp;
  set popUpStatus(bool pop) {
    openPopUp = pop;
    notifyListeners();
  }
}
