import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:we_book/Models/Authentications/FirebaseEmailPasswordLogin.dart';
import 'package:we_book/Models/Authentications/FirebaseFacebookSignIn.dart';
import 'package:we_book/Models/Authentications/FirebaseGoogleSignIn.dart';

import 'package:we_book/constants.dart';
import 'package:we_book/UIs/AppBarNormalUI.dart';
import 'package:we_book/UIs/TextFieldWidget.dart';
import 'package:we_book/UIs/PurpleRoundedButton.dart';

StreamController<String> emailStreamController =
    StreamController<String>.broadcast();
StreamController<String> passwordStreamController =
    StreamController<String>.broadcast();

class BookSellerLoginScreen extends StatefulWidget {
  @override
  _BookSellerLoginScreenState createState() => _BookSellerLoginScreenState();
}

class _BookSellerLoginScreenState extends State<BookSellerLoginScreen> {
  bool obscureText = true;
  Color color = Colors.grey;
  String email = "", password = "";
  String forgotPasswordValue = "";


@override
  void dispose() {
    super.dispose();
    BotToast.closeAllLoading();
  }
  @override
  void initState() {
    super.initState();
    emailStreamController.stream.listen((value) {
      email = value;
    });
    passwordStreamController.stream.listen((value) {
      password = value;
    });
  }

  String validateTextFields({String email, String password}) {
    String status = "";
    if (email.isEmpty || password.isEmpty) {
      status = "Failure";
      BotToast.showText(
          text: "One of the Fields are empty!", duration: Duration(seconds: 3));
    } else {
      status = "Success";
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;

 final snackBar = SnackBar(
      backgroundColor: purpleColor,
      elevation: 10,
      padding: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      duration: Duration(seconds: 5),
      content: Text(
        "Check your email",
      ),
      action: SnackBarAction(
        label: "OK",
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    return Scaffold(
      appBar: AppBarNormalUI().myAppBar(),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.fromLTRB(
                  screenWidth * 0.1025,
                  screenWidth * 0.0769,
                  screenWidth * 0.0769,
                  screenWidth * 0.051),
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
                        keyboardType: TextInputType.emailAddress,
                        streamController: emailStreamController,
                      ),
                      TextFieldWidget(
                        outsideText: 'Password',
                        hintText: 'Password',
                        icon: Icons.enhanced_encryption,
                        obscureText: obscureText,
                        streamController: passwordStreamController,
                        suffixIcon: IconButton(
                          color: color,
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: () {
                            setState(() {
                              if (obscureText == false) {
                                obscureText = true;
                                color = Colors.grey;
                              } else if (obscureText == true) {
                                obscureText = false;
                                color = Colors.blue;
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 0,
                        height: screenHeight * 0.01,
                      ),
                     Container(
                        height: 20,
                        width: screenWidth,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    actionsPadding: EdgeInsets.all(10),
                                    title: Text(
                                      "Enter your registered EMAIL",
                                      textAlign: TextAlign.center,
                                    ),
                                    titlePadding: EdgeInsets.all(5),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    content: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            hintText: "webook@gmail.com",
                                            prefixIcon: Icon(
                                              Icons.email,
                                              color: purpleColor,
                                            )),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onChanged: (value) {
                                          forgotPasswordValue = value;
                                        },
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          print(
                                              "Value of TextEditingController is } $forgotPasswordValue");
                                          if (forgotPasswordValue.isNotEmpty) {
                                            String result =
                                                await FirebaseEmailPasswordLogin()
                                                    .resetPassword(
                                                        context: context,
                                                        email:
                                                            forgotPasswordValue
                                                                .trim());
                                            Navigator.pop(context);
                                            if (result == "Success") {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          }
                                        },
                                        child: Text(
                                          "Send Email",
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  );
                                });
                          },
                    
                          child: Text(
                            "Forgot Password?",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: purpleColor,
                            ),
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
                          onPressed: () async {
                            if (validateTextFields(
                                    email: email, password: password) ==
                                "Success") {
                              FocusScope.of(context).requestFocus(FocusNode());
                              BotToast.showLoading();
                              print("email: $email  and password: $password ");
                              String result = await FirebaseEmailPasswordLogin()
                                  .login(
                                      email: email,
                                      password: password,
                                      userCategory: "Book Seller");
                              if (result == "Success") {
                               Navigator.of(context).pushNamedAndRemoveUntil(
                                    "BookSellerHomeScreen",
                                    (Route<dynamic> route) => false);
                              } else if (result == "Failure") {
                                BotToast.showText(text: "Invalid Credentials");
                                print("Failed to login");
                                BotToast.closeAllLoading();
                              }
                            }
                          },
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
                        height: screenWidth * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              String status = await FirebaseFacebookSignIn()
                                  .signInWithFacebook(
                                      userCategory: "Book Seller");
                              if (status == "Success") {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    "BookSellerHomeScreen",
                                    (Route<dynamic> route) => false);
                              }
                            },
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("images/facebookicon.png"),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.1,
                          ),
                          GestureDetector(
                            onTap: () async {
                              String status = await FirebaseGoogleSignIn()
                                  .signIn(userCategory: "Book Seller");
                              if (status == "Success") {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    "BookSellerHomeScreen",
                                    (Route<dynamic> route) => false);
                               
                              }
                            },
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("images/googleicon.png"),
                              backgroundColor: Colors.white,
                            ),
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
