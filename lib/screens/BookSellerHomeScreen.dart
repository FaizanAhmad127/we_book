import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_book/Provider%20ChangeNotifiers/BottomNavBarCN.dart';
import 'package:we_book/UIs/BottomNavBarV2.dart';
import 'package:we_book/screens/BookSellerProfile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookSellerHomeScreen extends StatefulWidget {
  @override
  _BookSellerHomeScreenState createState() => _BookSellerHomeScreenState();
}

class _BookSellerHomeScreenState extends State<BookSellerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: ChangeNotifierProvider(
          create: (context) => BottomNavBarCN(),
          child: Scaffold(
            bottomNavigationBar: BottomNavBarV2(),
            body:
                Consumer<BottomNavBarCN>(builder: (context, bottomNavBarCN, _) {
              if (bottomNavBarCN.getHomeScreen == true) {
                return Container(
                  child: Center(
                    child: Text("Hello world"),
                  ),
                );
              } else if (bottomNavBarCN.getProfileScreen == true) {
                return BookSellerProfile();
              } else {
                return Container();
              }
            }),
          )),
    );
  }
}
