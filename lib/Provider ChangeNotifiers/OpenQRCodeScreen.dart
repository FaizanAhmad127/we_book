import 'package:flutter/foundation.dart';

class OpenQRCodeScreen with ChangeNotifier {
  bool showQRCode = false;
  bool get qrStatus => showQRCode;
  set qrStatus(bool qr) {
    showQRCode = qr;
    notifyListeners();
  }
}
