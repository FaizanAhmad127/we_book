import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:we_book/UIs/AppBarNormalUI.dart';
import 'package:we_book/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookBuyerProfile extends StatefulWidget {
  @override
  _BookBuyerProfileState createState() => _BookBuyerProfileState();
}

class _BookBuyerProfileState extends State<BookBuyerProfile> {
  static String name = "Faizan Ahmad",
      email = "faizanahmad.imsc@gmail.com",
      currentPassword = "",
      newPassword = "",
      confirmNewPassword = "",
      phoneNumber = "";
  bool readBool = true;
  TextEditingController nameController = TextEditingController(text: name);
  TextEditingController emailController = TextEditingController(text: email);
  TextEditingController currentPasswordController =
      TextEditingController(text: currentPassword);
  TextEditingController newPasswordController =
      TextEditingController(text: newPassword);
  TextEditingController confirmNewPasswordController =
      TextEditingController(text: confirmNewPassword);
  TextEditingController phoneNumberController =
      TextEditingController(text: phoneNumber);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.addListener(() {
      setState(() {});
    });
    emailController.addListener(() {
      setState(() {});
    });
    currentPasswordController.addListener(() {
      setState(() {});
    });
    newPasswordController.addListener(() {
      setState(() {});
    });
    confirmNewPasswordController.addListener(() {
      setState(() {});
    });
    phoneNumberController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        FirebaseAuth.instance.signOut().whenComplete(() {
                          Navigator.pushNamed(context, "LoginSignupFragment");
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios),
                          Text(
                            "Logout",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: "Source Sans Pro"),
                          ),
                        ],
                      )),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          readBool = true;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.save),
                          Text(
                            "SAVE",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: "Source Sans Pro"),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: purpleColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[350],
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage("images/profileicon.jpg"),
                                radius: 40,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                  child: AutoSizeText(
                                "Change Picture",
                                maxLines: 1,
                                maxFontSize: 12,
                                minFontSize: 8,
                                style: TextStyle(
                                    backgroundColor: Colors.black,
                                    color: Colors.white,
                                    fontSize: 12),
                              )),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Expanded(
                        flex: 3,
                        child: ProfileTextFields(
                          controller: nameController,
                          readBool: readBool,
                          fontSize: 24,
                          containerWidth: 0.6,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Divider(
              indent: 0,
              endIndent: 0,
              height: 1,
              thickness: 2,
              color: purpleColor,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: AutoSizeText(
                      "Email: ",
                      style: TextStyle(
                          fontSize: 20, fontFamily: "Source Sans Pro"),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Expanded(
                    flex: 3,
                    child: ProfileTextFields(
                      controller: emailController,
                      readBool: readBool,
                      fontSize: 16,
                      containerWidth: 0.76,
                      keyboardType: TextInputType.emailAddress,
                      maxlines: 2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: AutoSizeText(
                      "Phone Number : ",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 20, fontFamily: "Source Sans Pro"),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Expanded(
                    flex: 3,
                    child: ProfileTextFields(
                      controller: phoneNumberController,
                      readBool: readBool,
                      fontSize: 14,
                      hintText: "030X-XXXXXXX",
                      containerWidth: 0.55,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: AutoSizeText(
                      "Current Password: ",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 20, fontFamily: "Source Sans Pro"),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Expanded(
                    flex: 3,
                    child: ProfileTextFields(
                      controller: currentPasswordController,
                      readBool: readBool,
                      fontSize: 14,
                      hintText: "Type current password here..",
                      obscureText: true,
                      containerWidth: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: AutoSizeText(
                      "New Password: ",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 20, fontFamily: "Source Sans Pro"),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Expanded(
                    flex: 3,
                    child: ProfileTextFields(
                      controller: newPasswordController,
                      readBool: readBool,
                      fontSize: 14,
                      hintText: "Type new password here..",
                      obscureText: true,
                      containerWidth: 0.57,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: AutoSizeText(
                      "Confirm Password: ",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 20, fontFamily: "Source Sans Pro"),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Expanded(
                    flex: 3,
                    child: ProfileTextFields(
                      controller: confirmNewPasswordController,
                      readBool: readBool,
                      fontSize: 14,
                      hintText: "Confirm password here..",
                      obscureText: true,
                      containerWidth: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.7,
                child: RaisedButton(
                  elevation: 3,
                  onPressed: () {
                    setState(() {
                      readBool = false;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: purpleColor,
                  child: Text(
                    "Edit Profile",
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
      ),
    ));
  }
}

class ProfileTextFields extends StatelessWidget {
  ProfileTextFields(
      {this.controller,
      this.readBool,
      this.fontSize,
      this.hintText = "",
      this.obscureText = false,
      this.containerWidth = 0.64,
      this.keyboardType = TextInputType.text,
      this.maxlines = 1,
      this.textColor = purpleColor});

  TextEditingController controller;
  bool readBool;
  double fontSize;
  String hintText;
  bool obscureText;
  double containerWidth;
  TextInputType keyboardType;
  int maxlines;
  Color textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * containerWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: TextField(
          maxLines: maxlines,
          keyboardType: keyboardType,
          obscureText: obscureText,
          controller: controller,
          readOnly: readBool,
          decoration: InputDecoration(
            focusColor: purpleColor,
            contentPadding: EdgeInsets.all(2),
            border: InputBorder.none,
            hintText: hintText,
          ),
          style: TextStyle(
              fontSize: fontSize,
              color: textColor,
              fontWeight: FontWeight.bold,
              fontFamily: "Source Sans Pro"),
        ),
      ),
    );
  }
}
