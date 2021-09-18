import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_book/Models/Books%20Detail/Transactions.dart';
import 'package:we_book/constants.dart';

class BSSales extends StatefulWidget {
  @override
  _BSSalesState createState() => _BSSalesState();
}

class _BSSalesState extends State<BSSales> {
  int todayProfitValue = 0,
      monthlyProfitValue = 0,
      yearlyProfitValue = 0;
  Transactions transactions;

  @override
  void initState() {
    super.initState();
    transactions = Transactions();
    profit();
  }

  void profit() async {
    await transactions.todayProfit().then((value) {
      todayProfitValue = value;
      return transactions.monthProfit();
    }).then((value) {
      monthlyProfitValue = value;
      return transactions.yearProfit();
    }).then((value) {
      yearlyProfitValue = value;
      setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                    color: purpleColor,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(10))),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    "Today",
                    presetFontSizes: [
                      20,
                      19,
                      18,
                      17,
                      16,
                      15,
                      14,
                      13,
                      12,
                      11,
                      10,
                      9,
                      8
                    ],
                    maxFontSize: 20,
                    minFontSize: 8,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Source Sans Pro",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                margin: EdgeInsets.all(10),
                elevation: 10,
                color: Colors.white,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: Center(
                  child: AutoSizeText(
                    "$todayProfitValue Rupees",
                    presetFontSizes: [
                      30,
                      25,
                      20,
                      19,
                      18,
                      17,
                      16,
                      15,
                      14,
                    ],
                    maxFontSize: 30,
                    minFontSize: 8,
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Source Sans Pro",
                      fontWeight: FontWeight.bold,
                      color: purpleColor,
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                    color: purpleColor,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(10))),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    "This Month",
                    presetFontSizes: [
                      20,
                      19,
                      18,
                      17,
                      16,
                      15,
                      14,
                      13,
                      12,
                      11,
                      10,
                      9,
                      8
                    ],
                    maxFontSize: 20,
                    minFontSize: 8,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Source Sans Pro",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                margin: EdgeInsets.all(10),
                elevation: 10,
                color: Colors.white,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: Center(
                  child: AutoSizeText(
                    "$monthlyProfitValue Rupees",
                    presetFontSizes: [
                      30,
                      25,
                      20,
                      19,
                      18,
                      17,
                      16,
                      15,
                      14,
                    ],
                    maxFontSize: 30,
                    minFontSize: 8,
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Source Sans Pro",
                      fontWeight: FontWeight.bold,
                      color: purpleColor,
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                    color: purpleColor,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(10))),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    "This Year",
                    presetFontSizes: [
                      20,
                      19,
                      18,
                      17,
                      16,
                      15,
                      14,
                      13,
                      12,
                      11,
                      10,
                      9,
                      8
                    ],
                    maxFontSize: 20,
                    minFontSize: 8,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Source Sans Pro",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                margin: EdgeInsets.all(10),
                elevation: 10,
                color: Colors.white,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: Center(
                  child: AutoSizeText(
                    "$yearlyProfitValue Rupees",
                    presetFontSizes: [
                      30,
                      25,
                      20,
                      19,
                      18,
                      17,
                      16,
                      15,
                      14,
                    ],
                    maxFontSize: 30,
                    minFontSize: 8,
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Source Sans Pro",
                      fontWeight: FontWeight.bold,
                      color: purpleColor,
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }


}
