import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_book/Models/PictureManagement/UploadDownloadImage.dart';
import 'package:we_book/Models/ShopDetails/FirebaseRetrieveShopDetails.dart';
import 'package:we_book/Models/ShopDetails/FirebaseUploadShopDetails.dart';
import 'package:we_book/UIs/MyAwesomeTextField.dart';
import 'package:we_book/UIs/PurpleRoundedButton.dart';
import 'package:we_book/constants.dart';

class BSShopDetailsScreen extends StatefulWidget {
  BSShopDetailsScreen();
  @override
  _BSShopDetailsScreenState createState() => _BSShopDetailsScreenState();
}

class _BSShopDetailsScreenState extends State<BSShopDetailsScreen> {
  String shopName = "",
      shopAddress = "Shop 3, Saddar Rd, Peshawar",
      shopCity = "Peshawar",
      shopCountry = "Pakistan",
      shopPhoneNumber = "03021234567",
      uid = "",
      shopPictureURL = "nothing";

  FirebaseUploadShopDetails firebaseUploadShopDetails;
  FirebaseRetrieveShopDetails firebaseRetrieveShopDetails;
  SharedPreferences sharedPreferences;
  UploadDownloadImage uploadDownloadImage;
  bool isAvatarTapped = false;

  TextEditingController shopNameController,
      shopAddressController,
      shopCityController,
      shopCountryController,
      shopPhoneNumberController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var firebaseAuth = FirebaseAuth.instance;
    uid = firebaseAuth.currentUser.uid;
    uploadDownloadImage = UploadDownloadImage();
    firebaseUploadShopDetails = FirebaseUploadShopDetails(uid: uid);
    firebaseRetrieveShopDetails = FirebaseRetrieveShopDetails(uid: uid);
    setTextFieldData();
  }

  Future setTextFieldData() async {
    print("SetTextFieldDAta");
    sharedPreferences = await SharedPreferences.getInstance();
    shopPictureURL = sharedPreferences.getString("shopPictureURL");
    shopName = sharedPreferences.getString("shopName");
    shopAddress = sharedPreferences.getString("shopAddress");
    shopCity = sharedPreferences.getString("shopCity");
    shopCountry = sharedPreferences.getString("shopCountry");
    shopPhoneNumber = sharedPreferences.getString("shopPhoneNumber");
    shopNameController = TextEditingController(text: shopName);
    shopAddressController = TextEditingController(text: shopAddress);
    shopCityController = TextEditingController(text: shopCity);
    shopCountryController = TextEditingController(text: shopCountry);
    shopPhoneNumberController = TextEditingController(text: shopPhoneNumber);
    setState(() {});
  }

  ImageProvider checkUrl(String url) {
    try {
      return NetworkImage(url);
    } catch (e) {
      return AssetImage("images/faisalbookdepot.jpg");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height - 80,
        child: Column(
          children: [
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: AutoSizeText(
                              shopName == null ? "Shop Name" : shopName,
                              maxLines: 1,
                              maxFontSize: 20,
                              minFontSize: 12,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                            fit: FlexFit.loose,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Flexible(
                            child: AutoSizeText(
                              shopAddress == null
                                  ? "Shop Address"
                                  : shopAddress,
                              maxFontSize: 16,
                              minFontSize: 12,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            fit: FlexFit.loose,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      GestureDetector(
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
                          backgroundImage: shopPictureURL == "nothing" ||
                                  shopPictureURL == null
                              ? AssetImage("images/faisalbookdepot.jpg")
                              : checkUrl(shopPictureURL),
                          child: isAvatarTapped != true
                              ? Container()
                              : IconButton(
                                  alignment: Alignment.bottomCenter,
                                  tooltip: "Change Shop Picture",
                                  iconSize: 20,
                                  color: Colors.white,
                                  icon: Icon(Icons.cloud_upload_sharp),
                                  onPressed: () async {
                                    isAvatarTapped = false;
                                    String saveUrl =
                                        shopPictureURL; //save the url and use it if user don't select anything from gallery
                                    if (uid == null) {
                                      BotToast.showText(
                                          text:
                                              "User is not registered/ Uid NULL");
                                    } else {
                                      print("Book Seller/$uid");
                                      try {
                                        shopPictureURL =
                                            await uploadDownloadImage // user will pick the image now...
                                                .imagePicker()
                                                .then((file) {
                                          return uploadDownloadImage
                                              .uploadImageToFirebaseStorage(
                                                  file,
                                                  "Book Seller/$uid/Shop Details",
                                                  "shopPicture");
                                        }); //this method will also store the image in firebase storage and return the url of an image

                                      } catch (e) {
                                        shopPictureURL = "nothing";
                                      }

                                      if (shopPictureURL != "nothing") {
                                        //if image is successfully picked
                                        BotToast.showLoading();
                                        await firebaseUploadShopDetails
                                            .updateShopPictureURL(
                                                url:
                                                    shopPictureURL) // upload the image url to firebase realtime database
                                            .then((value) =>
                                                firebaseRetrieveShopDetails
                                                    .getPictureURL()); //this method will now get the picture url and show image on defined part of a screen

                                        BotToast.closeAllLoading();
                                      } else {
                                        shopPictureURL = saveUrl;
                                      }
                                    }
                                    setState(() {});
                                  },
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
                  shopNameController: shopNameController,
                  outsideText: "Shop Name",
                )),
            Expanded(
                flex: 2,
                child: MyAwesomeTextField(
                  shopNameController: shopAddressController,
                  outsideText: "Shop Address",
                )),
            Expanded(
                flex: 2,
                child: MyAwesomeTextField(
                  shopNameController: shopCityController,
                  outsideText: "City",
                )),
            Expanded(
                flex: 2,
                child: MyAwesomeTextField(
                  shopNameController: shopCountryController,
                  outsideText: "Country",
                )),
            Expanded(
                flex: 2,
                child: MyAwesomeTextField(
                  shopNameController: shopPhoneNumberController,
                  outsideText: "Shop Phone Number",
                  keyboardType: TextInputType.phone,
                )),
            Expanded(
                flex: 1,
                child: PurpleRoundButton(
                  buttonText: "SAVE",
                  buttonWidth: 0.7,
                  buttonHeight: 0.02,
                  onPressed: () async {
                    String status = "";
                    shopName = shopNameController.text;
                    shopAddress = shopAddressController.text;
                    shopCity = shopCityController.text;
                    shopCountry = shopCountryController.text;
                    shopPhoneNumber = shopPhoneNumberController.text;
                    status = await firebaseUploadShopDetails.insertShopDetails(
                      shopName: shopName,
                      shopAddress: shopAddress,
                      shopCity: shopCity,
                      shopCountry: shopCountry,
                      shopPhoneNumber: shopPhoneNumber,
                    );
                    if (status == "Success") {
                      await firebaseRetrieveShopDetails.getProfileData();
                    }
                    setTextFieldData();
                  },
                )),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: GestureDetector(
                child: AutoSizeText(
                  "Want to View/Change shop location?",
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: "Source Sans Pro",
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "GetSellerLocation");
                },
              ),
            )),
            Expanded(flex: 1, child: Container()),
          ],
        ),
      ),
    );
  }
}
