import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:we_book/UIs/AppBarNormalUI.dart';
import 'package:we_book/constants.dart';

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
        appBar: AppBarNormalUI().myAppBar(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage("images/profileicon.jpg"),
                              radius: 40,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            GestureDetector(
                                child: AutoSizeText(
                              "Change Picture",
                              style: TextStyle(
                                backgroundColor: Colors.black,
                                color: Colors.white,
                              ),
                            ))
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        ProfileTextFields(
                          controller: nameController,
                          readBool: readBool,
                          fontSize: 24,
                          containerWidth: 0.6,
                        ),
                      ],
                    ),
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
                  Row(
                    children: [
                      Text(
                        "Email: ",
                        style: TextStyle(
                            fontSize: 20, fontFamily: "Source Sans Pro"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      ProfileTextFields(
                        controller: emailController,
                        readBool: readBool,
                        fontSize: 18,
                        containerWidth: 0.76,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    children: [
                      Text(
                        "Phone Number : ",
                        style: TextStyle(
                            fontSize: 20, fontFamily: "Source Sans Pro"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      ProfileTextFields(
                        controller: phoneNumberController,
                        readBool: readBool,
                        fontSize: 14,
                        hintText: "030X-XXXXXXX",
                        containerWidth: 0.55,
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    children: [
                      Text(
                        "Current Password: ",
                        style: TextStyle(
                            fontSize: 20, fontFamily: "Source Sans Pro"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      ProfileTextFields(
                        controller: currentPasswordController,
                        readBool: readBool,
                        fontSize: 14,
                        hintText: "Type current password here..",
                        obscureText: true,
                        containerWidth: 0.5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    children: [
                      Text(
                        "New Password: ",
                        style: TextStyle(
                            fontSize: 20, fontFamily: "Source Sans Pro"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      ProfileTextFields(
                        controller: newPasswordController,
                        readBool: readBool,
                        fontSize: 14,
                        hintText: "Type new password here..",
                        obscureText: true,
                        containerWidth: 0.57,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    children: [
                      Text(
                        "Confirm Password: ",
                        style: TextStyle(
                            fontSize: 20, fontFamily: "Source Sans Pro"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      ProfileTextFields(
                        controller: confirmNewPasswordController,
                        readBool: readBool,
                        fontSize: 14,
                        hintText: "Confirm password here..",
                        obscureText: true,
                        containerWidth: 0.5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Container(
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
                ],
              ),
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
      this.keyboardType = TextInputType.text});

  TextEditingController controller;
  bool readBool;
  double fontSize;
  String hintText;
  bool obscureText;
  double containerWidth;
  TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * containerWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: TextField(
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
              color: purpleColor,
              fontWeight: FontWeight.bold,
              fontFamily: "Source Sans Pro"),
        ),
      ),
    );
  }
}
