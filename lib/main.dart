import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:screen/screen.dart';
import 'package:we_book/Screens/BookBuyerScreens/BookBuyerHomeScreen.dart';
import 'package:we_book/Screens/BookBuyerScreens/BookBuyerLoginScreen.dart';
import 'package:we_book/Screens/BookBuyerScreens/BookBuyerSignupScreen.dart';
import 'package:we_book/Screens/BookSellerScreens/BSBooksEdit.dart';
import 'package:we_book/Screens/BookSellerScreens/BSBooksView.dart';
import 'package:we_book/Screens/BookSellerScreens/BSCheckInBooks.dart';
import 'package:we_book/Screens/BookSellerScreens/BSCheckOutManually.dart';
import 'package:we_book/Screens/BookSellerScreens/BSOutOfStockBooks.dart';
import 'package:we_book/Screens/BookSellerScreens/BSSales.dart';
import 'package:we_book/Screens/BookSellerScreens/BookSellerHomeScreen.dart';
import 'package:we_book/Screens/BookSellerScreens/BookSellerLoginScreen.dart';
import 'package:we_book/Screens/BookSellerScreens/BookSellerSignupScreen.dart';
import 'package:we_book/Screens/CommonScreens/LoginSignupFragment.dart';
import 'package:we_book/Screens/CommonScreens/SplashScreen.dart';
import 'package:we_book/UIs/BSQRScanner.dart';
import 'package:we_book/UIs/GetSellerLocation.dart';
import 'UIs/GoogleMapsUI.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding 
      .ensureInitialized(); //Returns an instance of the WidgetsBinding... you need it to access flutter engine from flutter framework. see flutter architecture for more.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> firebaseApp = Firebase.initializeApp();
    Screen.keepOn(
        true); // it will keep the screen light on till the app is not on foreground.
    return GestureDetector(
      behavior: HitTestBehavior
          .opaque, //Opaque targets can be hit by hit tests, causing them to both receive events within their bounds and prevent targets visually behind them from also receiving events.
      onTap: () {
        FocusScope.of(context).requestFocus(
            new FocusNode()); // to keep down the soft keypad after done typing in textfield etc
        print("Tapped, main.dart");
      },
      child: MaterialApp(
        debugShowCheckedModeBanner:
            false, //remove the yellow debug line from top right corner of an app
        showPerformanceOverlay: false, // remove the performance overlay
        builder: BotToastInit(), //initialize the toast so we can use it.
        navigatorObservers: [
          BotToastNavigatorObserver()
        ], // toast observer is created now we can observe for toast in other dart classes
        home: FutureBuilder(
          //Creates a widget that builds itself based on the latest snapshot of interaction with a Future. the builder must not be null.
          future: firebaseApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(" You have an error ${snapshot.error.toString()}");
              return Text("Something went Wrong!");
            } else if (snapshot.hasData) {
              return SplashScreen();
            } else {
              return Center(
                child:
                    CircularProgressIndicator(), // shows the progress indicator until the app won't get the firebase snapshot.
              );
            }
          },
        ),
        routes: {
          "SplashScreen":(context)=>SplashScreen(),
          "LoginSignupFragment": (context) => LoginSignUpFragment(),
          "BookBuyerLoginScreen": (context) => BookBuyerLoginScreen(),
          "BookBuyerSignupScreen": (context) => BookBuyerSignupScreen(),
          "BookSellerLoginScreen": (context) => BookSellerLoginScreen(),
          "BookSellerSignupScreen": (context) => BookSellerSignupScreen(),
          "BookBuyerHomeScreen": (context) => BookBuyerHomeScreen(),
          "GoogleMapsUI": (context) => GoogleMapsUI(),
          "BookSellerHomeScreen": (context) => BookSellerHomeScreen(),
          "BSQRScanner": (context) => BSQRScanner(),
          "GetSellerLocation": (context) => GetSellerLocation(),
          "CheckInBooks": (context) => CheckInBooks(),
          "BSCheckOutManually": (context) => BSCheckOutManually(),
          "BSBooksView": (context) => BSBooksView(),
          "BSBooksEdit": (context) => BSBooksEdit(),
          "BSOutOfStockBooks": (context) => BSOutOfStockBooks(),
          "BSSales": (context) => BSSales(),
        },
      ),
    );
  }
}
