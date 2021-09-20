import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:we_book/Models/Authentications/FirebaseEmailPasswordSignup.dart';
import 'package:we_book/UIs/AppBarNormalUI.dart';
import 'package:we_book/constants.dart';
import 'package:we_book/UIs/TextFieldWidget.dart';
import 'package:we_book/UIs/PurpleRoundedButton.dart';

StreamController<String> fullNameStreamController =
    StreamController<String>.broadcast();
StreamController<String> phoneNumberStreamController =
    StreamController<String>.broadcast();
StreamController<String> shopNameStreamController =
    StreamController<String>.broadcast();
StreamController<String> shopAddressStreamController =
    StreamController<String>.broadcast();
StreamController<String> emailStreamController =
    StreamController<String>.broadcast();
StreamController<String> passwordStreamController =
    StreamController<String>.broadcast();
StreamController<String> confirmPasswordStreamController =
    StreamController<String>.broadcast();

class BookSellerSignupScreen extends StatefulWidget {
  @override
  _BookSellerSignupScreenState createState() => _BookSellerSignupScreenState();
}

class _BookSellerSignupScreenState extends State<BookSellerSignupScreen> {
  String fullName = "",
      phoneNumber = "",
      email = "",
      shopName = "",
      shopAddress = "",
      password = "",
      confirmPassword = "";

  void initState() {
    super.initState();
    fullNameStreamController.stream.listen((value) {
      fullName = value;
    });
    phoneNumberStreamController.stream.listen((value) {
      phoneNumber = value;
    });

    shopNameStreamController.stream.listen((value) {
      shopName = value;
    });
    shopAddressStreamController.stream.listen((value) {
      shopAddress = value;
    });

    emailStreamController.stream.listen((value) {
      email = value;
    });
    passwordStreamController.stream.listen((value) {
      password = value;
    });
    confirmPasswordStreamController.stream.listen((value) {
      confirmPassword = value;
    });
  }

  String validateTextFields(
      String fulName,
      String phoneNumber,
      String email,
      String shopName,
      String shopAddress,
      String password,
      String confirmPassword) {
    String status;
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (fullName.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        email.isNotEmpty &&
        shopName.isNotEmpty &&
        shopAddress.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      if (emailValid == true) {
        if (password == confirmPassword) {
          status = "Success";
        } else {
          BotToast.showText(text: "Both passwords are not similar");
          status = "Failure";
        }
      } else {
        BotToast.showText(text: "Email pattern is wrong");
        status = "Failure";
      }
    } else {
      BotToast.showText(text: "One of the field is empty");
      status = "Failure";
    }

    return status;
  }

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
                        streamController: fullNameStreamController,
                      ),
                      TextFieldWidget(
                        outsideText: 'Phone Number',
                        hintText: '+923021234567',
                        keyboardType: TextInputType.phone,
                        icon: Icons.phone,
                        streamController: phoneNumberStreamController,
                      ),
                      TextFieldWidget(
                        outsideText: 'Email',
                        hintText: 'abc@gmail.com',
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        streamController: emailStreamController,
                      ),
                      TextFieldWidget(
                        outsideText: 'Shop Name',
                        hintText: 'Faisal Book Shop',
                        icon: Icons.book,
                        streamController: shopNameStreamController,
                      ),
                      TextFieldWidget(
                        outsideText: 'Shop Address',
                        hintText: 'Street 2, Saddar Bazar, Peshawar',
                        icon: Icons.pin_drop,
                        streamController: shopAddressStreamController,
                      ),
                      TextFieldWidget(
                        outsideText: 'Password',
                        hintText: 'Password',
                        icon: Icons.enhanced_encryption,
                        obscureText: true,
                        streamController: passwordStreamController,
                      ),
                      TextFieldWidget(
                        outsideText: 'Confirm Password',
                        hintText: 'Confirm Password',
                        icon: Icons.lock,
                        obscureText: true,
                        streamController: confirmPasswordStreamController,
                      ),
                      SizedBox(
                        width: 0,
                        height: screenHeight * 0.05,
                      ),
                      Center(
                        child: Container(
                          height: screenHeight * 0.065,
                          width: screenWidth * 0.8,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 3,
                              primary: purpleColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, "GetSellerLocation");
                            },
                            child: Text(
                              "Fetch Location (Optional)",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Source Sans Pro"),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      Center(
                        child: PurpleRoundButton(
                          buttonText: "SIGN UP",
                          buttonHeight: 0.065,
                          buttonWidth: 0.8,
                          onPressed: () async {
                            if (validateTextFields(
                                    fullName,
                                    phoneNumber,
                                    email,
                                    shopName,
                                    shopAddress,
                                    password,
                                    confirmPassword) ==
                                "Success") {
                              String result =
                                  await FirebaseEmailPasswordSignup()
                                      .registration(
                                          fullName: fullName,
                                          phoneNumber: phoneNumber,
                                          email: email,
                                          password: password,
                                          shopName: shopName,
                                          shopAddress: shopAddress,
                                          userCategory: "Book Seller");
                              if (result == "Success") {
                                BotToast.showText(
                                    text: "Successfully signed up",
                                    duration: Duration(seconds: 3));
                                Navigator.pushReplacementNamed(
                                    context, "BookSellerLoginScreen");
                              }
                            }
                          },
                        ),
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
                                  context, 'BookSellerLoginScreen');
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
