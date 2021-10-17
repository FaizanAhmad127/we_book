import 'package:flutter/foundation.dart';

class OpenQRCodeScreenCN with ChangeNotifier {
  Map<String, dynamic> bookMap;
  bool showQRCode = false;

  bool get qrStatus => showQRCode;
  Map<String, dynamic> get myBookMap => bookMap;

  set qrStatus(bool qr) {
    showQRCode = qr;
    notifyListeners();
  }

  set myBookMap(Map<String, dynamic> m) {
    bookMap = m;
    notifyListeners();
  }
}
