import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:we_book/Models/Books%20Detail/Book.dart';
import 'package:we_book/Models/QrManagement/FirebaseQr.dart';
import 'package:we_book/Models/UserProfileDetails/RetrieveProfileData.dart';
import 'package:we_book/Screens/BookSellerScreens/BSCheckOutQR.dart';
import 'package:we_book/constants.dart';

class BSQRScanner extends StatefulWidget {
  @override
  _BSQRScannerState createState() => _BSQRScannerState();
}

class _BSQRScannerState extends State<BSQRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  FirebaseAuth firebaseAuth;
  String uid, resultStatus = "Scan a code", previousResult;

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
                    '  Status: $resultStatus',
                    style: TextStyle(color: purpleColor, fontSize: 18),
                  )
                : Text(
                    '$resultStatus',
                    style: TextStyle(color: purpleColor, fontSize: 18),
                  ),
          ),
        )
      ],
    ));
  }

  void displayScanACodeMsg(String result) {
    if (previousResult != result) {
      setState(() {
        resultStatus = "Your QR Code is invalid";
      });

      Future.delayed(Duration(seconds: 3)).then((value) {
        setState(() {
          resultStatus = "Scan a code";
        });
      });
    }
    previousResult = result;
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      String bookSellerKey, bookBuyerKey, bookKey;
      List<String> bookKeysList = [];

      result = scanData;
      List<String> s = result.code.split(" ");

      if (s.length == 2) {
        bookSellerKey = s[0];
        bookBuyerKey = s[1];
        // bookKeysList.add(bookKey);
        if (uid == bookSellerKey) {
          controller.stopCamera();
          String buyerName = await RetrieveProfileData()
              .getBookBuyerNameUsingUID(bookBuyerKey);
          bookKeysList = await FirebaseQr()
              .getListOfBookKeysFromQRCodes(bookBuyerKey, bookSellerKey);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return BSCheckOutQR(
              buyerName: buyerName,
              bookSellerKey: bookSellerKey,
              booksMap: bookKeysList,
            );
          }));
        } else {
          displayScanACodeMsg(result.code);
        }
      } else if (s.length == 3) {
        bookSellerKey = s[0];
        bookBuyerKey = s[1];
        bookKey = s[2];
        bookKeysList.add(bookKey);
        if (uid == bookSellerKey) {
          controller.stopCamera();
          String buyerName = await RetrieveProfileData()
              .getBookBuyerNameUsingUID(bookBuyerKey);
          await Book().getBooksDetailsUsingBookKey(bookSellerKey, bookKeysList);

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return BSCheckOutQR(
              buyerName: buyerName,
              bookSellerKey: bookSellerKey,
              booksMap: bookKeysList,
            );
          }));
        } else {
          displayScanACodeMsg(result.code);
        }
      } else {
        displayScanACodeMsg(result.code);
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
