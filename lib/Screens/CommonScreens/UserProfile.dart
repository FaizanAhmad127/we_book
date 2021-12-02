import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_book/Constants/Strings.dart';
import 'package:we_book/Models/Authentications/FirebaseEmailPasswordLogin.dart';
import 'package:we_book/Models/Authentications/FirebaseFacebookSignIn.dart';
import 'package:we_book/Models/Authentications/FirebaseGoogleSignIn.dart';
import 'package:we_book/Models/UserProfileDetails/RetrieveProfileData.dart';
import 'package:we_book/Models/PictureManagement/UploadDownloadImage.dart';
import 'package:we_book/Models/UserProfileDetails/UploadProfileData.dart';
import 'package:we_book/UIs/MyAwesomeTextField.dart';
import 'package:we_book/UIs/PurpleRoundedButton.dart';
import 'package:we_book/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile extends StatefulWidget {
  final String category;
  UserProfile(this.category);
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
  SharedPreferences sharedPreferences;
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
  void dispose() {
    super.dispose();
    BotToast.closeAllLoading();
  }

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
    sharedPreferences = await SharedPreferences.getInstance();
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

  String checkUrl(String url) {
    try {
      return url;
    } catch (e) {
      return unknownProfileIcon;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    // double screenHeight = size.height;
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

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height - 95,
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
                        onTap: () async {
                          await FirebaseGoogleSignIn().signOut();
                          await FirebaseFacebookSignIn().facebookSignOut();
                          await FirebaseAuth.instance
                              .signOut()
                              .whenComplete(() {
                            sharedPreferences.clear();

                            Navigator.popAndPushNamed(
                                context, "LoginSignupFragment");
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
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: profilePictureURL == "nothing" ||
                                          profilePictureURL == null
                                      ? unknownProfileIcon
                                      : checkUrl(profilePictureURL),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(
                                    color: purpleColor,
                                  ),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error,
                                  ),
                                ),
                                isAvatarTapped != true
                                    ? Container()
                                    : Center(
                                        child: IconButton(
                                          alignment: Alignment.bottomCenter,
                                          tooltip: "Change Profile Picture",
                                          iconSize: 20,
                                          color: Colors.white,
                                          icon: Icon(Icons.cloud_upload_sharp),
                                          onPressed: () async {
                                            isAvatarTapped = false;
                                            String saveUrl =
                                                profilePictureURL; //save the url and use it if user don't select anything from gallery
                                            if (uid == null) {
                                              BotToast.showText(
                                                  text:
                                                      "User is not registered/ Uid NULL");
                                            } else {
                                              print("${widget.category}/$uid");
                                              try {
                                                profilePictureURL =
                                                    await uploadDownloadImage // user will pick the image now...
                                                        .imagePicker()
                                                        .then((file) {
                                                  return uploadDownloadImage
                                                      .uploadImageToFirebaseStorage(
                                                          file,
                                                          "${widget.category}/$uid",
                                                          "profilePicture");
                                                }); //this method will also store the image in firebase storage and return the url of an image

                                              } catch (e) {
                                                profilePictureURL = "nothing";
                                              }

                                              if (profilePictureURL !=
                                                  "nothing") {
                                                //if image is successfully picked
                                                BotToast.showLoading();
                                                await uploadProfileDataClassObject
                                                    .updatePictureURL(
                                                        url:
                                                            profilePictureURL) // upload the image url to firebase realtime database
                                                    .then((value) =>
                                                        retrieveProfileDataClassObject //this method will now get the picture url and show image on defined part of a screen
                                                            .getPictureURL());
                                                BotToast.closeAllLoading();
                                              } else {
                                                profilePictureURL = saveUrl;
                                              }
                                            }
                                            setState(() {});
                                          },
                                        ),
                                      ),
                              ],
                            )),
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
                    String status = "";
                    fullName = fullNameController.text;
                    email = emailController.text;
                    address = addressController.text;
                    city = cityController.text;
                    country = countryController.text;
                    phoneNumber = phoneNumberController.text;
                    status =
                        await uploadProfileDataClassObject.insertDataToDatabase(
                      fullName: fullName,
                      emailAddress: email,
                      physicalAddress: address,
                      city: city,
                      country: country,
                      phoneNumber: phoneNumber,
                    );
                    if (status == "Success") {
                      await RetrieveProfileData(
                              userCategory: widget.category, uid: uid)
                          .getProfileData();
                    }
                    setTextFieldData();
                  },
                )),
            Expanded(
              flex: 1,
              child: Container(
                height: 20,
                width: screenWidth,
                child: GestureDetector(
                  onTap: () async {
                    String result = await FirebaseEmailPasswordLogin()
                        .resetPassword(context: context, email: email.trim());

                    if (result == "Success") {
                      BotToast.showText(
                          text: "Check your email please",
                          contentColor: purpleColor,
                          clickClose: true,
                          duration: Duration(seconds: 5));
                    }
                  },
                  child: Center(
                    child: Text(
                      "Want to change password?",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: purpleColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
