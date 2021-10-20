import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:we_book/Models/QrManagement/FirebaseQr.dart';
import 'package:we_book/Provider%20ChangeNotifiers/OpenPopUpBookCN.dart';
import 'package:we_book/Provider%20ChangeNotifiers/OpenQRCodeScreenCN.dart';
import 'package:we_book/constants.dart';
import 'package:provider/provider.dart';

class QRCodeUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Provider.of<OpenQRCodeScreenCN>(context, listen: false)
                      .qrStatus = false;
                  Provider.of<OpenPopUpBookCN>(context, listen: false)
                      .popUpStatus = false;
                  // Navigator.popAndPushNamed(context, "BookBuyerHomeScreen");
                },
                child: Container(
                  child: Icon(
                    Icons.cancel,
                    size: 30,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.13,
                ),
              ),
              Expanded(
                flex: 4,
                child: Center(
                  child: QrImage(
                    data:
                        Provider.of<OpenQRCodeScreenCN>(context, listen: false)
                            .myBookMap["qrCodeKey"],
                    version: QrVersions.auto,
                    errorCorrectionLevel: QrErrorCorrectLevel.L,

                    padding: EdgeInsets.all(10),
                    constrainErrorBounds: true,
                    //embeddedImage: AssetImage('images/webooklogo.jpg'),
                    backgroundColor: Colors.white,
                    errorStateBuilder: (cxt, err) {
                      return Container(
                        child: Center(
                          child: Text(
                            "Uh oh! Something went wrong...",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08)),
              Expanded(
                flex: 2,
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        primary: purpleColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () async {
                        await FirebaseQr()
                            .uploadQrCode(Provider.of<OpenQRCodeScreenCN>(
                                    context,
                                    listen: false)
                                .myBookMap)
                            .then((status) {
                          if (status == "Success") {
                            BotToast.showText(text: "QR Code Saved");
                            Provider.of<OpenQRCodeScreenCN>(context, listen: false)
                      .qrStatus = false;
                 
                          }
                        });
                      },
                      child: AutoSizeText(
                        "Save QR Code",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: "Source Sans Pro"),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
