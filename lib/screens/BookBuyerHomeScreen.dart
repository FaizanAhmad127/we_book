import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_book/Provider%20ChangeNotifiers/BBBottomNavBarCN.dart';
import 'package:we_book/screens/BookBuyerDashBoard.dart';
import 'package:we_book/screens/BookBuyerProfile.dart';

import 'BookBuyerBottomNavigationBar.dart';

class BookBuyerHomeScreen extends StatefulWidget {
  @override
  _BookBuyerHomeScreenState createState() => _BookBuyerHomeScreenState();
}

class _BookBuyerHomeScreenState extends State<BookBuyerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: ChangeNotifierProvider(
          create: (context) => BBBottomNavBarCN(),
          child: Scaffold(
            //resizeToAvoidBottomInset: false,
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
