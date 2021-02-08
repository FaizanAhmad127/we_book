import 'package:flutter/material.dart';
import 'package:we_book/screens/BookBuyerSignupScreen.dart';
import 'package:we_book/screens/BookSellerLoginScreen.dart';
import 'package:we_book/screens/BookBuyerLoginScreen.dart';
import 'package:we_book/screens/LoginSignupFragment.dart';
import 'package:we_book/screens/BookSellerSignupScreen.dart';
import 'screens/BookBuyerHomeScreen.dart';
import 'UIs/GoogleMapsUI.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior
          .opaque, //Opaque targets can be hit by hit tests, causing them to both receive events within their bounds and prevent targets visually behind them from also receiving events.
      onTap: () {
        FocusScope.of(context).requestFocus(
            new FocusNode()); // to keep down the soft keypad after done typing in textfield etc
        print("Tapped, main.dart");
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        showPerformanceOverlay: false,
        initialRoute: "LoginSignupFragment",
        routes: {
          "LoginSignupFragment": (context) => LoginSignUpFragment(),
          "BookBuyerLoginScreen": (context) => BookBuyerLoginScreen(),
          "BookBuyerSignupScreen": (context) => BookBuyerSignupScreen(),
          "BookSellerLoginScreen": (context) => BookSellerLoginScreen(),
          "BookSellerSignupScreen": (context) => BookSellerSignupScreen(),
          "BookBuyerHomeScreen": (context) => BookBuyerHomeScreen(),
          "GoogleMapsUI": (context) => GoogleMapsUI(),
        },
      ),
    );
  }
}
