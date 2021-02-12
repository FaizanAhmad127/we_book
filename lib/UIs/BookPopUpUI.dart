import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_book/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:we_book/screens/BookBuyerHomeScreen.dart';

class BookPopUpUI extends StatelessWidget {
  BookPopUpUI(this._controller);
  StreamController<bool> _controller;

  void dispose() {
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, "BookBuyerHomeScreen");
                  },
                  child: Container(
                    child: Icon(Icons.exit_to_app),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.14,
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Image(
                    image: AssetImage("images/bookicon.png"),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.49,
                  child: Center(
                    child: AutoSizeText(
                      "Rich Dad Poor Dad",
                      style: TextStyle(
                        color: purpleColor,
                        fontFamily: "Source Sans Pro",
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              indent: 0,
              endIndent: 0,
              height: 0,
              thickness: 2,
              color: purpleColor,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Row(
              children: [
                Container(
                  child: Text(
                    "Author Name:",
                    style: TextStyle(
                      color: purpleColor,
                      fontFamily: "Source Sans Pro",
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.46,
                  child: Center(
                    child: AutoSizeText(
                      "Robert Kioski",
                      style: TextStyle(
                        color: purpleColor,
                        fontFamily: "Source Sans Pro",
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Row(
              children: [
                Container(
                  child: AutoSizeText(
                    "Price:",
                    style: TextStyle(
                      color: purpleColor,
                      fontFamily: "Source Sans Pro",
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.03,
                  width: MediaQuery.of(context).size.width * 0.49,
                  child: AutoSizeText(
                    " 1000/-",
                    style: TextStyle(
                      color: purpleColor,
                      fontFamily: "Source Sans Pro",
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Row(
              children: [
                Container(
                  child: AutoSizeText(
                    "Shop Name:",
                    style: TextStyle(
                      color: purpleColor,
                      fontFamily: "Source Sans Pro",
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.49,
                  child: Center(
                    child: AutoSizeText(
                      " Faisal Book Depot",
                      style: TextStyle(
                        color: purpleColor,
                        fontFamily: "Source Sans Pro",
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Row(
              children: [
                Container(
                  child: AutoSizeText(
                    "Shop Address:",
                    style: TextStyle(
                      color: purpleColor,
                      fontFamily: "Source Sans Pro",
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Center(
                    child: AutoSizeText(
                      " Street 2, Saddar bazar, Peshawar.",
                      style: TextStyle(
                        color: purpleColor,
                        fontFamily: "Source Sans Pro",
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.7,
              child: RaisedButton(
                elevation: 3,
                onPressed: () {
                  _controller.add(true);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: purpleColor,
                child: Text(
                  "Generate QR Code",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "Source Sans Pro"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
