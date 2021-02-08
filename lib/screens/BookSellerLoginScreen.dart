import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:we_book/constants.dart';
import 'package:we_book/UIs/AppBarNormalUI.dart';
import 'package:we_book/UIs/TextFieldWidget.dart';
import 'package:we_book/UIs/PurpleRoundedButton.dart';

class BookSellerLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWitdh = size.width;
    double screenHeight = size.height;
    return Scaffold(
      appBar: AppBarNormalUI().myAppBar(),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.fromLTRB(
                  screenWitdh * 0.1025,
                  screenWitdh * 0.0769,
                  screenWitdh * 0.0769,
                  screenWitdh * 0.051),
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "Login here",
                          style: TextStyle(
                              color: purpleColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.2,
                              fontFamily: "Source Sans Pro"),
                        ),
                      ),
                      TextFieldWidget(
                        outsideText: 'Email',
                        hintText: 'abc@gmail.com',
                        icon: Icons.email,
                      ),
                      TextFieldWidget(
                        outsideText: 'Password',
                        hintText: 'Password',
                        icon: Icons.enhanced_encryption,
                        obscureText: true,
                      ),
                      SizedBox(
                        width: 0,
                        height: screenHeight * 0.01,
                      ),
                      Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Forgot Password?",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: purpleColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 0,
                        height: screenHeight * 0.07,
                      ),
                      Center(
                        child: PurpleRoundButton(
                          buttonText: "LOGIN",
                          buttonHeight: 0.065,
                          buttonWidth: 0.8,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        width: 0,
                        height: screenHeight * 0.07,
                      ),
                      Stack(
                        children: <Widget>[
                          Divider(
                            indent: 0,
                            endIndent: 0,
                            height: 50,
                            thickness: 1,
                            color: purpleColor,
                          ),
                          Center(
                            heightFactor: 3,
                            child: Text(
                              "OR",
                              style: TextStyle(
                                  color: purpleColor,
                                  backgroundColor: Colors.white),
                            ),
                          )
                        ],
                      ),
                      Center(
                        child: Text(
                          "Login with",
                          style: TextStyle(color: purpleColor),
                        ),
                      ),
                      SizedBox(
                        height: screenWitdh * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            child: GestureDetector(),
                            backgroundImage:
                                AssetImage("images/facebookicon.png"),
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(
                            width: screenWitdh * 0.1,
                          ),
                          CircleAvatar(
                            child: GestureDetector(),
                            backgroundImage:
                                AssetImage("images/googleicon.png"),
                            backgroundColor: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Don't have an Account? ",
                            style: TextStyle(
                                color: purpleColor,
                                fontSize: 15,
                                letterSpacing: -0.2,
                                fontFamily: "Source Sans Pro"),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, "BookSellerSignupScreen");
                            },
                            child: Text(
                              "Sign Up ",
                              style: TextStyle(
                                  color: purpleColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.2,
                                  fontFamily: "Source Sans Pro"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }
}
