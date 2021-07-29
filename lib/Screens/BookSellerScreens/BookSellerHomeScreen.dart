import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_book/PreLoad/PreloadProfileData.dart';
import 'package:we_book/Provider%20ChangeNotifiers/BSBottomNavBarCN.dart';
import 'package:we_book/Screens/BookSellerScreens/BookSellerDashBoard.dart';
import 'package:we_book/UIs/BottomNavBarV2.dart';
import 'BSShopDetailsScreen.dart';
import 'BSTransactionScreen.dart';
import 'BookSellerProfile.dart';

class BookSellerHomeScreen extends StatefulWidget {
  @override
  _BookSellerHomeScreenState createState() => _BookSellerHomeScreenState();
}

class _BookSellerHomeScreenState extends State<BookSellerHomeScreen> {
  bool isPreLoadComplete = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setSharedPreferences();
  }

  Future setSharedPreferences() async {
    BotToast.showLoading();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("userCategory", "Book Seller");
    await PreloadProfileData().getReadyProfileData().then((value) {
      setState(() {
        BotToast.closeAllLoading();
        isPreLoadComplete = true;
      });
    });
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
              if (bottomNavBarCN.getHomeScreen == true && isPreLoadComplete) {
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
