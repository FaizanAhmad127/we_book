import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_book/Models/Books%20Detail/Book.dart';
import 'package:we_book/Models/Books%20Detail/Transactions.dart';
import 'package:we_book/Provider%20ChangeNotifiers/BSCheckOutCN.dart';

import '../../constants.dart';

class BSCheckOutQR extends StatefulWidget {
  final List<String> booksMap;
  final String bookSellerKey;
  final String buyerName;
  BSCheckOutQR({this.buyerName, this.booksMap, this.bookSellerKey});
  @override
  _BSCheckOutQRState createState() => _BSCheckOutQRState();
}

class _BSCheckOutQRState extends State<BSCheckOutQR> {
  List<Widget> items = [];

  Widget listItem(String bookKey, dynamic post) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 150,
        child: Card(
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
                                post["authorName"],
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
                                "Edition: ${post["bookEdition"]}",
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
                              flex: 2,
                              child: AutoSizeText(
                                "Shelf:  ${post["bookShelf"]}",
                                minFontSize: 8,
                                maxFontSize: 12,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontFamily: "Source Sans Pro"),
                              ),
                            ),
                            Expanded(
                                flex: 3,
                                child: IncrementDecrementWidget(
                                  bookName: post["bookName"],
                                  stock: post["bookQuantity"],
                                  finalBookPrice: post["finalBookPrice"],
                                  initialBookPrice: post["initialBookPrice"],
                                  bookKey: bookKey,
                                  count: 0,
                                )),
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

  @override
  void dispose() {
    super.dispose();
    BotToast.closeAllLoading();
  }

  @override
  void initState() {
    super.initState();
    getListViewItems();
  }

  Future getListViewItems() async {
    BotToast.showLoading();
    List<Widget> widgetList = [];
    Map<String, dynamic> bookDetailsMap = await Book()
        .getBooksDetailsUsingBookKey(widget.bookSellerKey, widget.booksMap)
        .catchError((error) {
      BotToast.closeAllLoading();
      print("error at getListViewItems at BsCheckOutQR.dart $error");
    }).whenComplete(() {
      BotToast.closeAllLoading();
    });
    if (bookDetailsMap.isNotEmpty) {
      bookDetailsMap.forEach((bookKey, value) {
        widgetList.add(listItem(bookKey, value));
      });
    } else {
      //if there is nothing in the list of books or recently deleted all of the books from database
      widgetList.add(Container(
        child: Center(
          child: AutoSizeText(
            "Nothing to show",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ));
    }
    setState(() {
      items = widgetList;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ChangeNotifierProvider(
              create: (context) => BSCheckOutCN(),
              child: Consumer<BSCheckOutCN>(
                builder: (context, checkOutCN, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: height * 0.66,
                        child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return items[index];
                            }),
                      ),
                      AnimatedOpacity(
                          opacity: 1,
                          duration: Duration(seconds: 3),
                          child: Container(
                            height: height * 0.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AutoSizeText(
                                        "Price",
                                        minFontSize: 8,
                                        maxFontSize: 16,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      DottedLine(
                                        lineLength: width * 0.6,
                                        dashLength: 2,
                                      ),
                                      Container(
                                        child: AutoSizeText(
                                          "${checkOutCN.getSubTotal}",
                                          minFontSize: 8,
                                          maxFontSize: 16,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AutoSizeText(
                                        "Discount 5%",
                                        minFontSize: 8,
                                        maxFontSize: 16,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      DottedLine(
                                        lineLength: width * 0.5,
                                        dashLength: 2,
                                      ),
                                      AutoSizeText(
                                        "${Provider.of<BSCheckOutCN>(context, listen: false).getDiscount} Rs",
                                        minFontSize: 8,
                                        maxFontSize: 16,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AutoSizeText(
                                        "Total",
                                        minFontSize: 8,
                                        maxFontSize: 16,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      DottedLine(
                                        lineThickness: 2,
                                        lineLength: width * 0.5,
                                        dashLength: 2,
                                      ),
                                      AutoSizeText(
                                        "${Provider.of<BSCheckOutCN>(context, listen: false).getTotal} Rs",
                                        minFontSize: 8,
                                        maxFontSize: 16,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 10,
                                          primary: purpleColor,
                                          minimumSize:
                                              Size(width * 0.9, height * 0.07),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5))),
                                        ),
                                        child: AutoSizeText(
                                          "CHECK OUT",
                                          minFontSize: 8,
                                          maxFontSize: 20,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1,
                                              fontFamily: "Source Sans Pro"),
                                        ),
                                        onPressed: () async {
                                          Map<String, dynamic> bookDetailsMap =
                                              {};

                                          String status;

                                          for (var i
                                              in Provider.of<BSCheckOutCN>(
                                                      context,
                                                      listen: false)
                                                  .getBookKeysToCheckOutMap
                                                  .entries) {
                                            String bookKey = i.key;
                                            int initialQuantity =
                                                i.value["initialQuantity"];
                                            int finalQuantity =
                                                i.value["finalQuantity"];

                                            //if user increase the amount from defualt zero
                                            if (finalQuantity > 0) {
                                              status = await Book()
                                                  .checkoutBook(
                                                      key: bookKey,
                                                      initialQuantity:
                                                          initialQuantity,
                                                      finalQuantity:
                                                          finalQuantity)
                                                  .catchError((error) {
                                                status = "Failure";

                                                print(
                                                    "book key at the time was $bookKey and error is $error");
                                              }).whenComplete(() {
                                                bookDetailsMap.addAll({
                                                  bookKey: {
                                                    "bookName":
                                                        i.value["bookName"],
                                                    "quantity": finalQuantity,
                                                    "unitPrice": i.value[
                                                        "finalBookPrice"],
                                                    "total": finalQuantity *
                                                        i.value[
                                                            "finalBookPrice"],
                                                    "profit": (i.value[
                                                                "finalBookPrice"] -
                                                            i.value[
                                                                "initialBookPrice"]) *
                                                        finalQuantity,
                                                  }
                                                });
                                              });
                                              if (status == "Failure") {
                                                print("status is Failure");

                                                break;
                                              }
                                            }
                                          }
                                          if (status == "Success") {
                                            print("All books are checkedOUT");
                                            status = await Transactions()
                                                .makeTransaction(bookDetailsMap,
                                                    widget.buyerName);
                                            if (status == "Success") {
                                              BotToast.showText(
                                                                  contentColor: purpleColor,
                                                                    text:
                                                                      "Book is checked out");
                                              Navigator.pop(context);
                                              print(
                                                  "Transaction is successful");
                                            } else {
                                              print("Transaction Failed!");
                                            }
                                          } else {
                                            print(
                                                "All books are not checkedOUT");
                                          }

                                          await getListViewItems();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ],
                  );
                },
              ))),
    );
  }
}

class IncrementDecrementWidget extends StatefulWidget {
  final int finalBookPrice, initialBookPrice, stock;
  final bookKey;
  final String bookName;
  int count;
  IncrementDecrementWidget(
      {this.bookName,
      this.initialBookPrice,
      this.finalBookPrice,
      this.stock,
      this.bookKey,
      this.count});
  @override
  _IncrementDecrementWidgetState createState() =>
      _IncrementDecrementWidgetState();
}

class _IncrementDecrementWidgetState extends State<IncrementDecrementWidget> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    //setting map of book keys , would use it to checkout books one by one
    Provider.of<BSCheckOutCN>(context, listen: false).setBooKKeysToCheckOutMap =
        {
      widget.bookKey: {
        "bookName": widget.bookName,
        "initialQuantity": widget.stock,
        "finalQuantity": widget.count,
        "initialBookPrice": widget.initialBookPrice,
        "finalBookPrice": widget.finalBookPrice,
      }
    };
    return Row(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: Size(10, 20),
              primary: purpleColor,
              shape: CircleBorder()),
          child: AutoSizeText(
            "+",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          onPressed: () {
            if (widget.count < widget.stock) {
              setState(() {
                widget.count++;
                //for total price without discount
                Provider.of<BSCheckOutCN>(context, listen: false).setSubTotal =
                    widget.finalBookPrice;
                //for discount price
                Provider.of<BSCheckOutCN>(context, listen: false).setDiscount =
                    Provider.of<BSCheckOutCN>(context, listen: false)
                        .getSubTotal;
              });
            } else if (widget.stock == 0) {
              BotToast.showText(text: "This book is out of stock");
            }
          },
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(width * 0.005, 0, width * 0.005, 0),
            child: AutoSizeText(
              "${widget.count}",
              style: TextStyle(fontSize: 16),
            )),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(1, 20),
            primary: purpleColor,
            shape: CircleBorder(),
          ),
          child: AutoSizeText(
            "-",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            setState(() {
              if (widget.count > 0) {
                widget.count--;

                Provider.of<BSCheckOutCN>(context, listen: false).setSubTotal =
                    -widget.finalBookPrice;
                Provider.of<BSCheckOutCN>(context, listen: false).setDiscount =
                    Provider.of<BSCheckOutCN>(context, listen: false)
                        .getSubTotal;
              }
            });
          },
        )
      ],
    );
  }
}
