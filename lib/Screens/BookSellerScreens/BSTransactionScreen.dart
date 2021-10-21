import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
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



Widget booksListViewItem(String bookKey, dynamic post) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    

    return Container(
      width: width * 0.6,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: purpleColor,
            )),
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                    child: Row(
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
                        ),),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                        Expanded(
                  child: AutoSizeText(
                                "Unit Price:  ${post["unitPrice"]}",
                                minFontSize: 8,
                                maxFontSize: 12,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
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
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1,
                                    fontFamily: "Source Sans Pro"),
                              ),
                            ),
                  ],
                ),
                Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: AutoSizeText(
                                  "Total: ${post["total"]}",
                                  minFontSize: 8,
                                  maxFontSize: 12,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1,
                                      fontFamily: "Source Sans Pro"),
                                ),
                              ),
                            ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }



  Widget listItem(String transactionKey, dynamic post) {
   
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 170,
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
                  
                  child: Padding(
                    padding: EdgeInsets.all(7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Row(
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
                                    "ID: $transactionKey",
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
                        ),
                        Expanded(
                          child: Row(
                            
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
                               Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: AutoSizeText(
                                    "Total: ${post["total"]}/-",
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
                              ),
                            ],
                          ),
                        ),
                        //for our book details listview
            Expanded(
                flex: 5,
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: Map.from(post["books"]).length,
                        itemBuilder: (context, index) {
                          return getBooksListViewItems(
                              Map.from(post["books"]))[index];
                        }))),
                       
                        
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
    BotToast.showLoading();
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
    }).whenComplete(() {
      BotToast.closeAllLoading();
    }).catchError((Object error) {
      BotToast.closeAllLoading();
      print("-------- error at getListviewItems() BSTransactionScreen.dart");
    });
    ;

    setState(() {
      items = widgetItemsList;
    });
  }
   List<Widget> getBooksListViewItems(
       Map<String, dynamic> booksMap) {
    List<Widget> widgetList = [];

    if (booksMap.isNotEmpty) {
      booksMap.forEach((bookKey, value) {
        widgetList.add(booksListViewItem(bookKey, value));
      });
    } else {
      widgetList.add(Center(
        child: Container(
          child: Text("Nothing to show"),
        ),
      ));
    }
    return widgetList;
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
  void dispose() {
    super.dispose();
    BotToast.closeAllLoading();
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
