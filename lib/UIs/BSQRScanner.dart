import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:we_book/Models/Books%20Detail/Book.dart';
import 'package:we_book/Models/QrManagement/FirebaseQr.dart';
import 'package:we_book/Provider%20ChangeNotifiers/BSCheckOutCN.dart';
import 'package:we_book/Screens/BookSellerScreens/BSCheckOutQR.dart';

class BSQRScanner extends StatefulWidget {
  @override
  _BSQRScannerState createState() => _BSQRScannerState();
}

class _BSQRScannerState extends State<BSQRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  FirebaseAuth firebaseAuth;
  String uid;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  void initState() {
    super.initState();
    firebaseAuth = FirebaseAuth.instance;
    uid = firebaseAuth.currentUser.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: QRView(
            overlay: QrScannerOverlayShape(),
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: (result != null)
                ? Text(
                    'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}')
                : Text('Scan a code'),
          ),
        )
      ],
    ));
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      String bookSellerKey, bookBuyerKey, bookKey;
      List<String> bookKeysList = [];

      result = scanData;
      List<String> s = result.code.split(" ");

      if (s.length == 2) {
        controller.stopCamera();
        bookSellerKey = s[0];
        bookBuyerKey = s[1];
        bookKeysList.add(bookKey);
        if (uid == bookSellerKey) {
         bookKeysList= await FirebaseQr()
              .getListOfBookKeysFromQRCodes(bookBuyerKey, bookSellerKey);
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return BSCheckOutQR(bookSellerKey: bookSellerKey,booksMap: bookKeysList,);
           }));
        }
      }
      else if (s.length == 3) {
        controller.stopCamera();
        bookSellerKey = s[0];
        bookBuyerKey = s[1];
        bookKey = s[2];
        bookKeysList.add(bookKey);
        if (uid == bookSellerKey) {
          await Book().getBooksDetailsUsingBookKey(bookSellerKey, bookKeysList);

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return BSCheckOutQR(
              bookSellerKey: bookSellerKey,
              booksMap: bookKeysList,
            );
          }));
        }
      } else {
        BotToast.showText(text: "QR Code is invalid");
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
