import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class BSTransactionScreen extends StatefulWidget {
  @override
  _BSTransactionScreenState createState() => _BSTransactionScreenState();
}

class _BSTransactionScreenState extends State<BSTransactionScreen> {
  List<dynamic> items = [];
  ScrollController listViewController = ScrollController();
  double topItem = 0;
  int pickedYear, pickedMonth, pickedDay;
  bool isPicked = false;

  Widget listItem(dynamic post) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 150,
        child: Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          color: Colors.white,
          shadowColor: Colors.green,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.green, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.all(7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                "Date: ${post["Year"]}-${post["Month"]}-${post["Day"]}   Time: ${post["Hour"]}:${post["Minute"]}:${post["Second"]} ",
                                minFontSize: 8,
                                maxFontSize: 14,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontFamily: "Source Sans Pro"),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: AutoSizeText(
                                  "ID#   ${post["TransactionId"]}",
                                  minFontSize: 8,
                                  maxFontSize: 12,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      fontFamily: "Source Sans Pro"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                "Book Name:  ${post["BookName"]}",
                                minFontSize: 8,
                                maxFontSize: 12,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontFamily: "Source Sans Pro"),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                "Sold Price:  ${post["SoldPrice"]}",
                                minFontSize: 8,
                                maxFontSize: 12,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontFamily: "Source Sans Pro"),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                "Buyer Name:  ${post["BuyerName"]}",
                                minFontSize: 8,
                                maxFontSize: 12,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontFamily: "Source Sans Pro"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void getListViewItems() {
    List<dynamic> responseList = transactions;
    List<Widget> widgetItemsList = [];
    responseList.forEach((post) {
      if (isPicked == true) {
        if (post["Year"] == pickedYear &&
            post["Month"] == pickedMonth &&
            post["Day"] == pickedDay) {
          widgetItemsList.add(listItem(post));
        }
      } else {
        widgetItemsList.add(listItem(post));
      }
    });
    setState(() {
      items = widgetItemsList;
    });
  }

  void pickDate() async {
    var pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1997),
      lastDate: DateTime(2030),
    );
    if (pickedDateTime != null) {
      pickedYear = pickedDateTime.year;
      pickedMonth = pickedDateTime.month;
      pickedDay = pickedDateTime.day;
      isPicked = true;
      getListViewItems();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListViewItems();
    listViewController.addListener(() {
      double value = listViewController.offset / 170;
      setState(() {
        topItem = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: purpleColor,
                    ),
                    child: AutoSizeText(
                      "Clear Filter",
                      style: TextStyle(color: Colors.white),
                    ),
                      onPressed: () {
                        setState(() {
                          isPicked = false;
                          getListViewItems();
                        });
                      }
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: purpleColor,
                    ),
                    child: AutoSizeText(
                      "Filter By Date",
                      style: TextStyle(color: Colors.white),
                    ),
                      onPressed: () {
                        pickDate();
                      }
                  )
                )
              ],
            )),
        Expanded(
          flex: 10,
          child: ListView.builder(
              itemCount: items.length,
              controller: listViewController,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                double scale = 1.0;
                if (topItem > 0) {
                  scale = index + 1 - topItem;
                  if (scale < 0) {
                    scale = 0;
                  } else if (scale > 1) {
                    scale = 1;
                  }
                }
                return Transform(
                  transform: Matrix4.identity()..scale(scale, scale),
                  alignment: Alignment.topCenter,
                  child: items[index],
                );
              }),
        ),
        Expanded(
          flex: 1,
          child: Opacity(
              opacity: 0.3,
              child: Container(
                color: Colors.transparent,
              )),
        )
      ],
    );
  }
}
