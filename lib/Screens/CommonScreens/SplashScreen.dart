import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:we_book/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<String> getSplashImage() async {
    String url = await FirebaseStorage.instance
        .ref()
        .child("splashImage.png")
        .getDownloadURL();

    return url;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: FutureBuilder(
        future: getSplashImage(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(" You have an error ${snapshot.error.toString()}");
            return Text("Something went Wrong!");
          } else if (snapshot.hasData) {
            Future.delayed(Duration(seconds: 10)).then((value) {
              Navigator.popAndPushNamed(context, "LoginSignupFragment");
            });
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.grey,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image(
                      image: NetworkImage(snapshot.data),
                    ),
                  ),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width * 0.05,
                  left: MediaQuery.of(context).size.width * 0.05,
                  bottom: MediaQuery.of(context).size.height * 0.03,
                  child: Container(
                    decoration: BoxDecoration(
                        color: purpleColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: AutoSizeText(
                        "Note: This is a promotion content, for publishing yours please email us at faizanahmad.imsc@gmail.com",
                        maxLines: 2,
                        maxFontSize: 22,
                        minFontSize: 8,
                        style: TextStyle(
                            fontSize: 22,
                            letterSpacing: 1.2,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child:
                  CircularProgressIndicator(), // shows the progress indicator until the app won't get the firebase snapshot.
            );
          }
        },
      ),
    ));
  }
}
