import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_book/constants.dart';

class BookPopUpUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
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
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image(
                    image: AssetImage("images/bookicon.png"),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Center(
                    child: Text(
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
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
                  child: Text(
                    "Robert Kioski",
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
                  child: Text(
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
                  child: Text(
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
                  child: Text(
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
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Center(
                    child: Text(
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
                  child: Text(
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
                    child: Text(
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.12),
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.7,
              child: RaisedButton(
                elevation: 3,
                onPressed: () {},
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
