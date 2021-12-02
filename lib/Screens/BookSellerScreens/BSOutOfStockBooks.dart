import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_book/Models/Books%20Detail/Book.dart';

class BSOutOfStockBooks extends StatefulWidget {
  @override
  _BSOutOfStockBooksState createState() => _BSOutOfStockBooksState();
}

class _BSOutOfStockBooksState extends State<BSOutOfStockBooks> {
  List<dynamic> items = [];
  ScrollController listViewController = ScrollController();
  double topItem = 0;
  String searchString = "";
  TextEditingController searchTextFieldController = TextEditingController();
  Book book;

  Widget listItem(String key, dynamic post) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 150,
        child: Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          color: Colors.white,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                    padding: EdgeInsets.all(7),
                    child: CachedNetworkImage(
                      height: 100,
                      width: 60,
                      imageUrl: post["bookImage"],
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.contain),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                      ),
                    )),
              ),
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
                                post["bookName"],
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
                              child: AutoSizeText(
                                "BY  ${post["authorName"]}",
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
                                "Editon:  ${post["bookEdition"]}",
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
                                "Price:  ${post["finalBookPrice"]}",
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
                                "Stock:  ${post["bookQuantity"]}",
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
                                "Shelf:  ${post["bookShelf"]}",
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
    BotToast.showLoading();
    List<Widget> widgetItemsList = [];
    bool isAnyBookFound = false;
    await book.getAllBooksOfSeller().then((responseList) {
      if (responseList.isNotEmpty) {
        responseList.forEach((key, post) {
          if (post["bookQuantity"] == 0) {
            isAnyBookFound = true;
            searchString = searchString.toUpperCase();
            String bookName = post["bookName"].toString().toUpperCase();
            if (searchString.isNotEmpty) {
              if (bookName.contains(searchString)) {
                widgetItemsList.add(listItem(key, post));
              }
            } else {
              widgetItemsList.add(listItem(key, post));
            }
          }
        });
      }
      if (responseList.isEmpty || isAnyBookFound == false) {
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
      widgetItemsList.add(Container(
          child: Center(
            child: AutoSizeText(
              "Nothing to show",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ));
      print("-------- error at getListviewItems() BSOutOfStockBooks.dar");
    });
    ;
    setState(() {
      items = widgetItemsList;
    });
  }
@override
  void dispose() {
    super.dispose();
    BotToast.closeAllLoading();
  }
  @override
  void initState() {
    super.initState();
    book = Book();
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
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                  child: Row(
                children: [
                  Expanded(
                    child: Card(
                      margin: EdgeInsets.all(10),
                      elevation: 10,
                      color: Colors.white,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          controller: searchTextFieldController,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              searchString = value;
                              getListViewItems();
                            } else {
                              searchString = value;
                              getListViewItems();
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Book Name...",
                            border: InputBorder.none,
                            suffixIcon: Icon(FontAwesomeIcons.search),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
              Expanded(
                flex: 8,
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
          ),
        ),
      ),
    );
  }
}
