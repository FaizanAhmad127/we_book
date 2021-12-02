import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:we_book/Models/QrManagement/FirebaseQr.dart';
import 'package:we_book/UIs/AppBarNormalUI.dart';
import 'package:we_book/constants.dart';

class BookBuyerMyQRCodes extends StatefulWidget {
  @override
  _BookBuyerMyQRCodesState createState() => _BookBuyerMyQRCodesState();
}

class _BookBuyerMyQRCodesState extends State<BookBuyerMyQRCodes> {
  List<dynamic> wholeItems = [];
  bool showQr = false;
  String qrKey = "";
  FirebaseQr firebaseQr;
  Widget booksListViewItem(
      String qrKey, String bookKey, Map<String, dynamic> bookMap) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String deleteQrKey = qrKey + " " + bookKey;

    return Container(
      width: width * 0.7,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
            side: BorderSide(
              color: purpleColor,
            )),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      "${bookMap["bookName"]}",
                      minFontSize: 10,
                      maxFontSize: 18,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await firebaseQr
                            .deleteBookQR(deleteQrKey)
                            .then((status) {
                          if (status == "Success") {
                            setState(() {
                              getWholeListViewItems();
                            });
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AutoSizeText(
                            "Delete",
                            minFontSize: 8,
                            maxFontSize: 18,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          Icon(
                            Icons.delete_forever,
                            size: 20,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
                SizedBox(
                  height: height * 0.01,
                ),
                Expanded(
                  child: Row(
                    children: [
                      AutoSizeText(
                        "Author: ",
                        maxFontSize: 14,
                        minFontSize: 8,
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      //author name
                      AutoSizeText(
                        "${bookMap["authorName"]}",
                        maxFontSize: 14,
                        minFontSize: 8,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    //for edition and price
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //for edition
                    Row(
                      children: [
                        AutoSizeText(
                          "Edition: ",
                          maxFontSize: 14,
                          minFontSize: 8,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        AutoSizeText(
                          "${bookMap["bookEdition"]}",
                          maxFontSize: 14,
                          minFontSize: 8,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        AutoSizeText(
                          "Price: ",
                          maxFontSize: 14,
                          minFontSize: 8,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        AutoSizeText(
                          "${bookMap["finalBookPrice"]}/-",
                          maxFontSize: 14,
                          minFontSize: 8,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget wholeListViewItem(Map<String, dynamic> post) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5, top: 5),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)))),
                      elevation: MaterialStateProperty.all(10),
                      fixedSize: MaterialStateProperty.all(
                          Size(width * 0.3, height * 0.04))),
                  onPressed: () async{
                    await firebaseQr.deleteSellerQR(post["bookSellerKey"]).then((status) {
                      if (status == "Success") {
                        setState(() {
                          getWholeListViewItems();
                        });
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AutoSizeText(
                        "Delete",
                        minFontSize: 8,
                        maxFontSize: 18,
                        style: TextStyle(color: Colors.amber, fontSize: 18),
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      Icon(
                        Icons.delete_forever,
                        size: 20,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //for shpname,phoneno and address
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      //for shop name and address
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //for shopname
                            Row(
                              children: [
                                Icon(FontAwesomeIcons.building),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                AutoSizeText(
                                  "${post["shopName"]}",
                                  maxFontSize: 14,
                                  minFontSize: 8,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            SizedBox(width: width * 0.03),
                            //for phone number
                            Row(
                              children: [
                                Icon(FontAwesomeIcons.phone),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                AutoSizeText(
                                  "${post["shopPhoneNumber"]}",
                                  maxFontSize: 14,
                                  minFontSize: 8,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.04),
                      //for address
                      Expanded(
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.mapMarker),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            AutoSizeText(
                              "${post["shopAddress"]}",
                              maxFontSize: 14,
                              minFontSize: 8,
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            Divider(
              color: purpleColor,
            ),

            //for our book details listview
            Expanded(
                flex: 2,
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: Map.from(post["bookMap"]).length,
                        itemBuilder: (context, index) {
                          return getBooksListViewItems(
                              post["qrKey"], Map.from(post["bookMap"]))[index];
                        }))),
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () {
                        //print("qrkey is ${post["qrKey"]}");
                        setState(() {
                          showQr = true;
                          qrKey = post["qrKey"];
                        });
                      },
                      child: AutoSizeText(
                        "View QR Code",
                        maxFontSize: 14,
                        minFontSize: 8,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                )
              ],
            )),
          ],
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
    firebaseQr = FirebaseQr();
    
    getWholeListViewItems();
  }

  Future getWholeListViewItems() async {
    BotToast.showLoading();
    List<Widget> widgetList = [];
    List<Map<String, dynamic>> bookSellerQRCodes =
        await firebaseQr.retieveQrCode();

    if (bookSellerQRCodes.isNotEmpty) {
      bookSellerQRCodes.forEach((element) {
        widgetList.add(wholeListViewItem(element));
      });
    } else {
      widgetList.add(Center(
          child: Container(
        child: Center(
          child: AutoSizeText(
            "Nothing to show",
            style: TextStyle(fontSize: 20),
          ),
        ),
      )));
    }
    BotToast.closeAllLoading();
    setState(() {
      wholeItems = widgetList;
    });
  }

  List<Widget> getBooksListViewItems(
      String qrKey, Map<String, dynamic> booksMap) {
    List<Widget> widgetList = [];

    if (booksMap != {}) {
      booksMap.forEach((key, value) {
        widgetList.add(booksListViewItem(qrKey, key, value));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarNormalUI().myAppBar(),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Stack(
              children: [
               
                ListView.builder(
                    itemCount: wholeItems.length,
                    itemBuilder: (context, index) {
                      return wholeItems[index];
                    }),
                showQr == true
                    ? Positioned(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        bottom: MediaQuery.of(context).size.height * 0.05,
                        top: MediaQuery.of(context).size.height * 0.05,
                        child: Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: purpleColor, width: 4)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showQr = false;
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(
                                        Icons.cancel,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                              ),
                              Container(
                                child: Center(
                                    child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: QrImage(
                                    data: qrKey,
                                    version: QrVersions.auto,
                                    errorCorrectionLevel: QrErrorCorrectLevel.L,
                                    padding: EdgeInsets.all(10),
                                    constrainErrorBounds: true,
                                    backgroundColor: Colors.white,
                                    errorStateBuilder: (cxt, err) {
                                      return Container(
                                        child: Center(
                                          child: Text(
                                            "Uh oh! Something went wrong...",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            )));
  }
}
