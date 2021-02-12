import 'package:flutter/material.dart';
import 'package:we_book/constants.dart';
import 'package:screen/screen.dart';
import 'package:we_book/UIs/AppBarNormalUI.dart';

class LoginSignUpFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Screen.keepOn(true);
    // Screen.setBrightness(0.5);

    Size size = MediaQuery.of(context).size;
    double screenWitdh = size.width;
    double screenHeight = size.height;
    return Scaffold(
        appBar: AppBarNormalUI().myAppBar(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(screenWitdh * 0.1025,
                screenWitdh * 0.0769, screenWitdh * 0.0769, screenWitdh * 0.2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Center(
                  child: Text(
                    "Who Are You?",
                    style: TextStyle(
                        color: purpleColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.2,
                        fontFamily: "Source Sans Pro"),
                  ),
                ),
                Container(
                  height: screenHeight * 0.2,
                  width: screenWitdh * 0.8,
                  child: RaisedButton(
                    elevation: 3,
                    onPressed: () {
                      Navigator.pushNamed(context, 'BookBuyerLoginScreen');
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: purpleColor,
                    child: Text(
                      "BOOK BUYER",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Source Sans Pro",
                          fontSize: 19),
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWitdh * 0.05,
                ),
                Container(
                  height: screenHeight * 0.2,
                  width: screenWitdh * 0.8,
                  child: RaisedButton(
                    elevation: 3,
                    onPressed: () {
                      Navigator.pushNamed(context, "BookSellerLoginScreen");
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: purpleColor,
                    child: Text(
                      "BOOK SELLER",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Source Sans Pro",
                          fontSize: 19),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
