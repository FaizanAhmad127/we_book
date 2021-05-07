import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_book/Models/RetrieveProfileData.dart';
import 'package:we_book/Models/UploadDownloadImage.dart';
import 'package:we_book/Models/UploadProfileData.dart';
import 'package:we_book/UIs/MyAwesomeTextField.dart';
import 'package:we_book/UIs/PurpleRoundedButton.dart';
import 'package:we_book/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookBuyerProfile extends StatefulWidget {
  String category;
  BookBuyerProfile(this.category);
  @override
  _BookBuyerProfileState createState() => _BookBuyerProfileState();
}

class _BookBuyerProfileState extends State<BookBuyerProfile> {
  String fullName,
      email,
      address,
      city,
      country,
      phoneNumber,
      uid,
      profilePictureURL = "nothing";
  var uploadProfileDataClassObject;
  var retrieveProfileDataClassObject;
  var uploadDownloadImage;
  bool isAvatarTapped = false;

  //TextEditingController are used to control the input of the textfields
  TextEditingController fullNameController,
      emailController,
      addressController,
      cityController,
      countryController,
      phoneNumberController;

  @override
  void initState() {
    super.initState();
    var firebaseAuth = FirebaseAuth.instance;
    uid = firebaseAuth.currentUser.uid;
    uploadDownloadImage = UploadDownloadImage();
    uploadProfileDataClassObject =
        UploadProfileData(userCategory: widget.category, uid: uid);
    retrieveProfileDataClassObject =
        RetrieveProfileData(userCategory: widget.category, uid: uid);
    setTextFieldData();
  }

  Future setTextFieldData() async {
    print("SetTextFieldDAta");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    profilePictureURL = sharedPreferences.getString("profilePictureURL");
    fullName = sharedPreferences.getString("fullName");
    email = sharedPreferences.getString("emailAddress");
    address = sharedPreferences.getString("physicalAddress");
    city = sharedPreferences.getString("city");
    country = sharedPreferences.getString("country");
    phoneNumber = sharedPreferences.getString("phoneNumber");
    fullNameController = TextEditingController(text: fullName);
    emailController = TextEditingController(text: email);
    addressController = TextEditingController(text: address);
    cityController = TextEditingController(text: city);
    countryController = TextEditingController(text: country);
    phoneNumberController = TextEditingController(text: phoneNumber);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height - 80,
        child: Column(
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
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            if (isAvatarTapped == true) {
                              isAvatarTapped = false;
                            } else {
                              isAvatarTapped = true;
                            }
                            setState(() {});
                          },
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: profilePictureURL == "nothing"
                                ? AssetImage("images/noimage.JPG")
                                : NetworkImage(profilePictureURL),
                            child: isAvatarTapped != true
                                ? Container()
                                : IconButton(
                                    alignment: Alignment.bottomCenter,
                                    tooltip: "Change Profile Picture",
                                    iconSize: 20,
                                    color: Colors.white,
                                    icon: Icon(Icons.cloud_upload_sharp),
                                    onPressed: () async {
                                      if (uid == null) {
                                        BotToast.showText(
                                            text:
                                                "User is not registered/ Uid NULL");
                                      } else {
                                        print("${widget.category}/$uid");
                                        String url = profilePictureURL =
                                            await uploadDownloadImage // use will pick the image now...
                                                .imagePicker(
                                                    //this method will also store the image in firebase storage and return the url of an image
                                                    "${widget.category}/$uid",
                                                    "profilePicture");
                                        if (url != "nothing") {
                                          //if image is successfully picked
                                          await uploadProfileDataClassObject
                                              .updatePictureURL(
                                                  url:
                                                      url) // upload the image url to firebase realtime database
                                              .then((value) =>
                                                  retrieveProfileDataClassObject //this method will now get the picture url and show image on defined part of a screen
                                                      .getPictureURL());
                                        }
                                        setState(() {});
                                      }
                                    },
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Expanded(
                        flex: 3,
                        child: AutoSizeText(
                          fullName == null ? "Username" : fullName,
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
                  onPressed: () async {
                    fullName = fullNameController.text;
                    email = emailController.text;
                    address = addressController.text;
                    city = cityController.text;
                    country = countryController.text;
                    phoneNumber = phoneNumberController.text;
                    await uploadProfileDataClassObject.insertDataToDatabase(
                      fullName: fullName,
                      emailAddress: email,
                      physicalAddress: address,
                      city: city,
                      country: country,
                      phoneNumber: phoneNumber,
                    );
                    setTextFieldData();
                  },
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
        ),
      ),
    );
  }
}
