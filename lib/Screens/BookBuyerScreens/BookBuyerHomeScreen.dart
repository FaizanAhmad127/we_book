import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_book/PreLoad/PreloadProfileData.dart';
import 'package:we_book/Provider%20ChangeNotifiers/BBBottomNavBarCN.dart';
import 'package:we_book/Screens/BookBuyerScreens/BookBuyerDashBoard.dart';
import 'package:we_book/Screens/BookBuyerScreens/BookBuyerProfile.dart';
import 'package:we_book/Screens/CommonScreens/UserProfile.dart';

import 'BookBuyerBottomNavigationBar.dart';

class BookBuyerHomeScreen extends StatefulWidget {
  @override
  _BookBuyerHomeScreenState createState() => _BookBuyerHomeScreenState();
}

class _BookBuyerHomeScreenState extends State<BookBuyerHomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
          create: (context) => BBBottomNavBarCN(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            bottomNavigationBar: BookBuyerBottomNavigationBar(),
            body: Consumer<BBBottomNavBarCN>(
                builder: (context, bottomNavBarCN, _) {
              if (bottomNavBarCN.getHomeScreen == true) {
                return BookBuyerDashBoard();
              } else if (bottomNavBarCN.getProfileScreen == true) {
                return BookBuyerProfile();
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
  sharedPreferences.setString("userCategory", "Book Buyer");
  PreloadProfileData().getReadyProfileData();
}
