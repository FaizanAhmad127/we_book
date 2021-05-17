import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:we_book/Models/FirebaseEmailPasswordSignup.dart';
import 'package:we_book/UIs/AppBarNormalUI.dart';
import 'package:we_book/constants.dart';
import 'package:we_book/UIs/TextFieldWidget.dart';
import 'package:we_book/UIs/PurpleRoundedButton.dart';

class BookBuyerSignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;
    return Scaffold(
      appBar: AppBarNormalUI().myAppBar(),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.fromLTRB(screenWidth * 0.1025,
                  screenWidth * 0.07, screenWidth * 0.0769, screenWidth * 0.03),
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "Sign Up here",
                          style: TextStyle(
                              color: purpleColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.2,
                              fontFamily: "Source Sans Pro"),
                        ),
                      ),
                      TextFieldWidget(
                        outsideText: 'Full Name',
                        hintText: 'Anthony Hofstad',
                        icon: Icons.account_box,
                      ),
                      TextFieldWidget(
                        outsideText: 'Phone Number',
                        hintText: '+923021234567',
                        icon: Icons.phone,
                      ),
                      TextFieldWidget(
                        outsideText: 'Email',
                        hintText: 'abc@gmail.com',
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFieldWidget(
                        outsideText: 'Password',
                        hintText: 'Password',
                        icon: Icons.enhanced_encryption,
                        obscureText: true,
                      ),
                      TextFieldWidget(
                        outsideText: 'Confirm Password',
                        hintText: 'Confirm Password',
                        icon: Icons.lock,
                        obscureText: true,
                      ),
                      SizedBox(
                        width: 0,
                        height: screenHeight * 0.05,
                      ),
                      Center(
                        child: PurpleRoundButton(
                            buttonText: "SIGN UP",
                            buttonHeight: 0.065,
                            buttonWidth: 0.8,
                            onPressed: () async {
                              String result =
                                  await FirebaseEmailPasswordSignup()
                                      .registration(
                                          "faizanahmad.imsc@gmail.com",
                                          "12345678");
                              if (result == "Success") {
                                Navigator.popAndPushNamed(
                                    context, "BookBuyerLoginScreen");
                              } else if (result == "Failure") {
                                BotToast.showText(text: "Failed to signup");
                              }
                            }),
                      ),
                      SizedBox(
                        width: 0,
                        height: screenHeight * 0.04,
                      ),
                      Stack(
                        children: <Widget>[
                          Divider(
                            height: 50,
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
                          "Sign Up with",
                          style: TextStyle(color: purpleColor),
                        ),
                      ),
                      SizedBox(
                        height: screenWidth * 0.05,
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
                            width: screenWidth * 0.1,
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
                            "Already have an Account? ",
                            style: TextStyle(
                                color: purpleColor,
                                fontSize: 15,
                                letterSpacing: -0.2,
                                fontFamily: "Source Sans Pro"),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, 'BookBuyerLoginScreen');
                            },
                            child: Text(
                              "Log In ",
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
