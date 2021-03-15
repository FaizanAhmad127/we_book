import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_book/UIs/MyAwesomeTextField.dart';
import 'package:we_book/UIs/PurpleRoundedButton.dart';
import 'package:we_book/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookBuyerProfile extends StatefulWidget {
  @override
  _BookBuyerProfileState createState() => _BookBuyerProfileState();
}

class _BookBuyerProfileState extends State<BookBuyerProfile> {
  static String fullName = "Faizan Ahmad",
      email = "faizanahmad.imsc@gmail.com",
      address = "Khyber Colony 2, Tehkal Payan",
      city = "Peshawar",
      country = "Pakistan",
      phoneNumber = "03221234567";
  TextEditingController fullNameController =
      TextEditingController(text: fullName);
  TextEditingController emailController = TextEditingController(text: email);
  TextEditingController addressController =
      TextEditingController(text: address);
  TextEditingController cityController = TextEditingController(text: city);
  TextEditingController countryController =
      TextEditingController(text: country);
  TextEditingController phoneNumberController =
      TextEditingController(text: phoneNumber);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      FirebaseAuth.instance.signOut().whenComplete(() {
                        Navigator.pushNamed(context, "LoginSignupFragment");
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          "Logout",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: "Source Sans Pro"),
                        ),
                        Icon(FontAwesomeIcons.walking),
                      ],
                    )),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Card(
            margin: EdgeInsets.all(10),
            elevation: 10,
            color: Colors.white,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("images/profileicon.jpg"),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Expanded(
                    flex: 3,
                    child: AutoSizeText(
                      "FAIZAN AHMAD",
                      maxLines: 1,
                      maxFontSize: 20,
                      minFontSize: 12,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          height: 2,
          thickness: 2,
          color: purpleColor,
          indent: 0,
          endIndent: 0,
        ),
        Expanded(
            flex: 2,
            child: MyAwesomeTextField(
              shopNameController: fullNameController,
              outsideText: "Full Name",
            )),
        Expanded(
            flex: 2,
            child: MyAwesomeTextField(
              shopNameController: emailController,
              outsideText: "Email Address",
            )),
        Expanded(
            flex: 2,
            child: MyAwesomeTextField(
              shopNameController: addressController,
              outsideText: "Physical Address",
            )),
        Expanded(
            flex: 2,
            child: MyAwesomeTextField(
              shopNameController: cityController,
              outsideText: "City",
            )),
        Expanded(
            flex: 2,
            child: MyAwesomeTextField(
              shopNameController: countryController,
              outsideText: "Country",
            )),
        Expanded(
            flex: 2,
            child: MyAwesomeTextField(
              shopNameController: phoneNumberController,
              outsideText: "Phone Number",
              keyboardType: TextInputType.phone,
            )),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Expanded(
            flex: 1,
            child: PurpleRoundButton(
              buttonText: "SAVE",
              buttonWidth: 0.7,
              buttonHeight: 0.02,
              onPressed: () {},
            )),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.008,
        ),
        Expanded(
            flex: 1,
            child: AutoSizeText(
              "Want to change password?",
              style: TextStyle(
                color: Colors.blue,
              ),
            )),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
      ],
    );
  }
}
