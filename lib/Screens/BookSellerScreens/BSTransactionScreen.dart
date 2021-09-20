import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_book/Models/Books%20Detail/Transactions.dart';

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
  Transactions bookTransactions;

  Widget listItem(String key, dynamic post) {
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
            children: [
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.all(7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                "Date:  ${post["day"]}-${post["month"]}-${post["year"]}  Time: ${post["hour"]}:${post["minute"]} ${post["amPm"]}",
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
                                alignment: Alignment.centerRight,
                                child: AutoSizeText(
                                  "ID: $key",
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
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                "Book Name:  ${post["bookName"]}",
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
                                "Unit Price:  ${post["unitPrice"]}",
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
                            Expanded(
                              child: AutoSizeText(
                                "Quantity: ${post["quantity"]}",
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
                            Expanded(
                              child: AutoSizeText(
                                "Total: ${post["total"]}",
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
                                "Buyer Name:  ${post["buyerName"]}",
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

  void getListViewItems() async {
    List<Widget> widgetItemsList = [];

    await bookTransactions.getAllTransactions().then((responseList) {
      if (responseList.isNotEmpty) {
        responseList.forEach((key, post) {
          if (isPicked == true) {
            if (post["year"] == pickedYear &&
                post["month"] == pickedMonth &&
                post["day"] == pickedDay) {
              widgetItemsList.add(listItem(key, post));
            }
          } else {
            widgetItemsList.add(listItem(key, post));
          }
        });
      } else {
        //if there is nothing in the list of books or recently deleted all of the books from database
        widgetItemsList.add(Container(
          child: Center(
            child: AutoSizeText(
              "Nothing to show",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ));
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
    super.initState();
    bookTransactions = Transactions();
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
                      }),
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
                        }))
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
      ],
    );
  }
}
