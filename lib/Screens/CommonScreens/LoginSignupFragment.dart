import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_book/constants.dart';
import 'package:we_book/UIs/AppBarNormalUI.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginSignUpFragment extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;

  Future<String> findUserCategory() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("userCategory");
  }

  @override
  Widget build(BuildContext context) {
    //Screen.keepOn(true);
    // Screen.setBrightness(0.5);
    Size size = MediaQuery.of(context).size;
    double screenWitdh = size.width;
    double screenHeight = size.height;
    return Scaffold(
        appBar: AppBarNormalUI().myAppBar(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(screenWitdh * 0.1025,
                screenWitdh * 0.0769, screenWitdh * 0.0769, screenWitdh * 0.2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      "Who Are You?",
                      style: TextStyle(
                          color: purpleColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.2,
                          fontFamily: "Source Sans Pro"),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                      //height: screenHeight * 0.05,
                      ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: screenHeight * 0.2,
                    width: screenWitdh * 0.8,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        primary: purpleColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () async {
                        if (user != null &&
                            await findUserCategory() == "Book Buyer") {
                          Navigator.pushNamed(context, 'BookBuyerHomeScreen');
                        } else {
                          Navigator.pushNamed(context, 'BookBuyerLoginScreen');
                        }
                      },
                      child: Text(
                        "BOOK BUYER",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Source Sans Pro",
                            fontSize: 19),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                      //height: screenHeight * 0.05,
                      ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: screenHeight * 0.2,
                    width: screenWitdh * 0.8,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        primary: purpleColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () async {
                        if (user != null &&
                            await findUserCategory() == "Book Seller") {
                          Navigator.pushNamed(context, 'BookSellerHomeScreen');
                        } else {
                          Navigator.pushNamed(context, 'BookSellerLoginScreen');
                        }
                      },
                      child: Text(
                        "BOOK SELLER",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Source Sans Pro",
                            fontSize: 19),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
