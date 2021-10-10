
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_book/PreLoad/PreloadProfileData.dart';
import 'package:we_book/Provider%20ChangeNotifiers/BBBottomNavBarCN.dart';
import 'package:we_book/Screens/BookBuyerScreens/BookBuyerDashBoard.dart';
import 'package:we_book/Screens/BookBuyerScreens/BookBuyerProfile.dart';


import 'BookBuyerBottomNavigationBar.dart';

class BookBuyerHomeScreen extends StatefulWidget {
  @override
  _BookBuyerHomeScreenState createState() => _BookBuyerHomeScreenState();
}

class _BookBuyerHomeScreenState extends State<BookBuyerHomeScreen> {
  String fullName = "";
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ChangeNotifierProvider(
      create: (context) => BBBottomNavBarCN(),
      child: FutureBuilder(
        future: setSharedPreferences(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(" You have an error ${snapshot.error.toString()}");
            return Text("Something went Wrong!");
          } else if (snapshot.hasData) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              bottomNavigationBar: BookBuyerBottomNavigationBar(
                fullName: snapshot.data,
              ),
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
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ), // shows the progress indicator until the app won't get the firebase snapshot.
            );
          }
        },
      ),
    ));
  }

  Future<String> setSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("userCategory", "Book Buyer");
    await PreloadProfileData().getReadyProfileData();
    fullName = sharedPreferences.getString("fullName");
    return fullName;
  }
}
