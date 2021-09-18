import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:we_book/Models/Books%20Detail/Book.dart';
import 'package:we_book/Models/Books%20Detail/Transactions.dart';
import 'package:we_book/Provider%20ChangeNotifiers/BSCheckOutCN.dart';
import 'package:we_book/constants.dart';

class BSCheckOutManually extends StatefulWidget {
  @override
  _BSCheckOutManuallyState createState() => _BSCheckOutManuallyState();
}

class _BSCheckOutManuallyState extends State<BSCheckOutManually> {
  List<dynamic> items = [];
  ScrollController listViewController = ScrollController();
  double topItem = 0;
  String searchString = "";
  TextEditingController searchTextFieldController = TextEditingController();
  Book book;
  Transactions transactions;

  Widget listItem(String key, dynamic post) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 150,
        child: Card(
          //margin: EdgeInsets.all(10),
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
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                    ),
                  ),
                ),
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
                          ],
                        ),
                        Row(
                          children: [
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
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  primary: purpleColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          bottomLeft: Radius.circular(5))),
                                ),
                                child: AutoSizeText(
                                  "CHECK OUT",
                                  minFontSize: 8,
                                  maxFontSize: 14,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      fontFamily: "Source Sans Pro"),
                                ),
                                onPressed: () {
                                  TextEditingController textEditingController =
                                      TextEditingController();
                                  if (post["bookQuantity"] == 0) {
                                    BotToast.showText(text: "OUT OF STOCK");
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder:
                                            (context) => ChangeNotifierProvider(
                                                  create: (context) =>
                                                      BSCheckOutCN(),
                                                  child: Consumer<BSCheckOutCN>(
                                                      builder: (context,
                                                          checkOutCN, _) {
                                                    return AlertDialog(
                                                      title: Center(
                                                        child: Text(
                                                          "${post["bookName"]}",
                                                        ),
                                                      ),
                                                      titlePadding:
                                                          EdgeInsets.all(5),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        bottom: 10,
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      content: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.15,
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Center(
                                                                    child: AutoSizeText(
                                                                        "Quantity"),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            primary:
                                                                                purpleColor,
                                                                            minimumSize:
                                                                                Size(10, 15)),
                                                                        child: Text(
                                                                            "-"),
                                                                        onPressed:
                                                                            () {
                                                                          if (checkOutCN.getQuantity >
                                                                              1) {
                                                                            setState(() {
                                                                              checkOutCN.setQuanity = checkOutCN.getQuantity - 1;
                                                                            });
                                                                          }
                                                                        },
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      AutoSizeText(
                                                                          "${checkOutCN.getQuantity}"),
                                                                      SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            primary:
                                                                                purpleColor,
                                                                            minimumSize:
                                                                                Size(10, 15)),
                                                                        child: Text(
                                                                            "+"),
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            checkOutCN.setQuanity =
                                                                                checkOutCN.getQuantity + 1;
                                                                          });
                                                                        },
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.05,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  AutoSizeText(
                                                                      "Buyer Name: "),
                                                                  SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.05,
                                                                  ),
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.4,
                                                                    height: 20,
                                                                    child:
                                                                        TextField(
                                                                      controller:
                                                                          textEditingController,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        hintText:
                                                                            "Hamza Ali",
                                                                        isDense:
                                                                            true,
                                                                        contentPadding: EdgeInsets.fromLTRB(
                                                                            5.0,
                                                                            1.0,
                                                                            5.0,
                                                                            1.0),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          )),
                                                      actions: [
                                                        Center(
                                                          child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              primary:
                                                                  purpleColor,
                                                            ),
                                                            child: Text(
                                                              "Check Out",
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              await book
                                                                  .checkoutBook(
                                                                      key: key,
                                                                      initialQuantity:
                                                                          post[
                                                                              "bookQuantity"],
                                                                      finalQuantity:
                                                                          checkOutCN
                                                                              .getQuantity)
                                                                  .then(
                                                                      (status) {
                                                                if (status ==
                                                                    "Success") {
                                                                  String
                                                                      buyerName =
                                                                      "Anonymous";
                                                                  if (textEditingController
                                                                      .text
                                                                      .isNotEmpty) {
                                                                    buyerName =
                                                                        textEditingController
                                                                            .text;
                                                                  }
                                                                  int total = post[
                                                                          "finalBookPrice"] *
                                                                      checkOutCN
                                                                          .getQuantity;
                                                                  int profit = (post[
                                                                              "finalBookPrice"] -
                                                                          post[
                                                                              "initialBookPrice"]) *
                                                                      checkOutCN
                                                                          .getQuantity;
                                                                  transactions
                                                                      .makeTransaction(
                                                                          buyerName,
                                                                          post[
                                                                              "bookName"],
                                                                          post[
                                                                              "finalBookPrice"],
                                                                          checkOutCN
                                                                              .getQuantity,
                                                                          total,
                                                                          profit)
                                                                      .then(
                                                                          (status) {
                                                                    if (status ==
                                                                        "Success") {
                                                                      getListViewItems();
                                                                      Navigator.pop(
                                                                          context);
                                                                    }
                                                                  });
                                                                }
                                                              });
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  }),
                                                ));
                                  }
                                },
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

    await book.getAllBooksOfSeller().then((responseList) {
      if (responseList.isNotEmpty) {
        responseList.forEach((key, value) {
          searchString = searchString.toUpperCase();
          String bookName = value["bookName"].toString().toUpperCase();
          if (searchString.isNotEmpty) {
            if (bookName.contains(searchString)) {
              widgetItemsList.add(listItem(key, value));
            }
          } else {
            widgetItemsList.add(listItem(key, value));
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
    }).catchError((Object error) {
      print("-------- error at getListviewItems() BSCheckoutManaully.dar");
    });

    setState(() {
      items = widgetItemsList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    book = Book();
    transactions = Transactions();
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
