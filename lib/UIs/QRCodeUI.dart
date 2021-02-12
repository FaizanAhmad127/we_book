import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:we_book/constants.dart';

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
                  Navigator.popAndPushNamed(context, "BookBuyerHomeScreen");
                },
                child: Container(
                  child: Icon(Icons.exit_to_app),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.13,
              ),
              Center(
                child: QrImage(
                  data: '12h34j5k6l8jd8jd8dj8h43l3l39',
                  version: 3,
                  errorCorrectionLevel: QrErrorCorrectLevel.L,
                  padding: EdgeInsets.all(10),
                  constrainErrorBounds: true,
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: RaisedButton(
                    elevation: 3,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: purpleColor,
                    child: Text(
                      "Save QR Code",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "Source Sans Pro"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
