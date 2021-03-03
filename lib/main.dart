import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:we_book/screens/BookBuyerProfile.dart';
import 'package:we_book/screens/BookBuyerSignupScreen.dart';
import 'package:we_book/screens/BookSellerHomeScreen.dart';
import 'package:we_book/screens/BookSellerLoginScreen.dart';
import 'package:we_book/screens/BookBuyerLoginScreen.dart';
import 'package:we_book/screens/LoginSignupFragment.dart';
import 'package:we_book/screens/BookSellerSignupScreen.dart';
import 'screens/BookBuyerHomeScreen.dart';
import 'UIs/GoogleMapsUI.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> firebaseApp = Firebase.initializeApp();
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
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        home: FutureBuilder(
          future: firebaseApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(" You have an error ${snapshot.error.toString()}");
              return Text("Something went Wrong!");
            } else if (snapshot.hasData) {
              return BookSellerHomeScreen();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        routes: {
          "LoginSignupFragment": (context) => LoginSignUpFragment(),
          "BookBuyerLoginScreen": (context) => BookBuyerLoginScreen(),
          "BookBuyerSignupScreen": (context) => BookBuyerSignupScreen(),
          "BookSellerLoginScreen": (context) => BookSellerLoginScreen(),
          "BookSellerSignupScreen": (context) => BookSellerSignupScreen(),
          "BookBuyerHomeScreen": (context) => BookBuyerHomeScreen(),
          "GoogleMapsUI": (context) => GoogleMapsUI(),
          "BookBuyerProfile": (context) => BookBuyerProfile(),
          "BookSellerHomeScreen": (context) => BookSellerHomeScreen(),
        },
      ),
    );
  }
}
