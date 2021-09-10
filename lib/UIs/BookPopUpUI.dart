import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_book/Provider%20ChangeNotifiers/OpenPopUpBookCN.dart';
import 'package:we_book/Provider%20ChangeNotifiers/OpenQRCodeScreenCN.dart';
import 'package:we_book/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

class BookPopUpUI extends StatelessWidget {
  BookPopUpUI(); //this._controller);
  //final StreamController<bool> _controller;

  void dispose() {
    // _controller.close();
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Provider.of<OpenPopUpBookCN>(context, listen: false)
                          .popUpStatus = false;
                    },
                    child: Container(
                      child: Icon(Icons.cancel),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.14,
                      child: Image(
                        image: AssetImage("images/bookicon.png"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Center(
                        child: AutoSizeText(
                          "Rich Dad Poor Dad",
                          maxFontSize: 24,
                          minFontSize: 12,
                          style: TextStyle(
                            color: purpleColor,
                            fontFamily: "Source Sans Pro",
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
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
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: AutoSizeText(
                        "Author Name:",
                        maxFontSize: 19,
                        minFontSize: 12,
                        maxLines: 1,
                        style: TextStyle(
                          color: purpleColor,
                          fontFamily: "Source Sans Pro",
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      //height: MediaQuery.of(context).size.height * 0.07,
                      // width: MediaQuery.of(context).size.width * 0.46,
                      child: Center(
                        child: AutoSizeText(
                          "Robert Kioski",
                          maxFontSize: 20,
                          minFontSize: 12,
                          //maxLines: 1,
                          style: TextStyle(
                            color: purpleColor,
                            fontFamily: "Source Sans Pro",
                            fontSize: 20,
                          ),
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
                      maxFontSize: 19,
                      minFontSize: 12,
                      maxLines: 1,
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
                      maxFontSize: 19,
                      minFontSize: 12,
                      maxLines: 1,
                      style: TextStyle(
                        color: purpleColor,
                        fontFamily: "Source Sans Pro",
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: AutoSizeText(
                        "Shop Name:",
                        maxFontSize: 19,
                        minFontSize: 12,
                        maxLines: 1,
                        style: TextStyle(
                          color: purpleColor,
                          fontFamily: "Source Sans Pro",
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.49,
                      child: Center(
                        child: AutoSizeText(
                          " Faisal Book Depot",
                          maxFontSize: 20,
                          minFontSize: 12,
                          style: TextStyle(
                            color: purpleColor,
                            fontFamily: "Source Sans Pro",
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: AutoSizeText(
                        "Shop Address:",
                        maxFontSize: 19,
                        minFontSize: 12,
                        maxLines: 1,
                        style: TextStyle(
                          color: purpleColor,
                          fontFamily: "Source Sans Pro",
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Center(
                        child: AutoSizeText(
                          " Street 2, Saddar bazar, Peshawar",
                          maxFontSize: 20,
                          minFontSize: 12,
                          style: TextStyle(
                            color: purpleColor,
                            fontFamily: "Source Sans Pro",
                            fontSize: 20,
                          ),
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    primary: purpleColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Provider.of<OpenQRCodeScreenCN>(context, listen: false)
                        .qrStatus = true;
                    //_controller.add(true);
                  },
                  child: AutoSizeText(
                    "Generate QR Code",
                    maxFontSize: 20,
                    minFontSize: 12,
                    maxLines: 1,
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
      ),
    );
  }
}
