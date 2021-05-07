import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_book/PreLoad/PreloadProfileData.dart';
import 'package:we_book/Provider%20ChangeNotifiers/BSBottomNavBarCN.dart';
import 'package:we_book/UIs/BottomNavBarV2.dart';
import 'package:we_book/screens/BookSellerProfile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'BSShopDetailsScreen.dart';
import 'BSTransactionScreen.dart';
import 'BookSellerDashBoard.dart';

class BookSellerHomeScreen extends StatefulWidget {
  @override
  _BookSellerHomeScreenState createState() => _BookSellerHomeScreenState();
}

class _BookSellerHomeScreenState extends State<BookSellerHomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: ChangeNotifierProvider(
          create: (context) => BSBottomNavBarCN(),
          child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            bottomNavigationBar: BottomNavBarV2(),
            body: Consumer<BSBottomNavBarCN>(
                builder: (context, bottomNavBarCN, _) {
              if (bottomNavBarCN.getHomeScreen == true) {
                return BookSellerDashBoard();
              } else if (bottomNavBarCN.getProfileScreen == true) {
                return BookSellerProfile();
              } else if (bottomNavBarCN.getShopScreen == true) {
                return BSShopDetailsScreen();
              } else if (bottomNavBarCN.getTransactionScreen == true) {
                return BSTransactionScreen();
              } else {
                return Container();
              }
            }),
          )),
    );
  }
}

void setSharedPreferences() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("userCategory", "Book Seller");
  PreloadProfileData().getReadyProfileData();
}
