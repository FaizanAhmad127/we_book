import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_book/UIs/MyAwesomeTextField.dart';
import 'package:we_book/UIs/PurpleRoundedButton.dart';
import 'package:we_book/UIs/TextFieldWidget.dart';
import 'package:we_book/constants.dart';
import 'package:we_book/screens/BookBuyerProfile.dart';

class BSShopDetailsScreen extends StatefulWidget {
  @override
  _BSShopDetailsScreenState createState() => _BSShopDetailsScreenState();
}

class _BSShopDetailsScreenState extends State<BSShopDetailsScreen> {
  static String shopName = "Faisal Book Depot";
  static String shopAddress = "Shop 3, Saddar Rd, Peshawar";
  static String shopCity = "Peshawar";
  static String shopCountry = "Pakistan";
  static String shopPhoneNumber = "03021234567";

  TextEditingController shopNameController =
      TextEditingController(text: shopName);
  TextEditingController shopAddressController =
      TextEditingController(text: shopAddress);
  TextEditingController shopCityController =
      TextEditingController(text: shopCity);
  TextEditingController shopCountryController =
      TextEditingController(text: shopCountry);
  TextEditingController shopPhoneNumberController =
      TextEditingController(text: shopPhoneNumber);

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
                              "FAISAL BOOK DEPOT",
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
                              "Shop 3, Saddar Rd, Pesahwar",
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
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage("images/faisalbookdepot.jpg"),
                      )
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
                  onPressed: () {},
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
