import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_book/constants.dart';

class BookSellerDashBoard extends StatefulWidget {
  @override
  _BookSellerDashBoardState createState() => _BookSellerDashBoardState();
}

class _BookSellerDashBoardState extends State<BookSellerDashBoard> {
  ScrollController listViewController = ScrollController();
  double topItem = 0;
  List<Widget> items = [];
  void getListViewItems() {
    List<dynamic> responseList = booksData;
    List<Widget> widgetItemsList = [];
    responseList.forEach((post) {
      widgetItemsList.add(Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    "images/${post["Image"]}",
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                          child: AutoSizeText(
                            post["BookName"],
                            minFontSize: 12,
                            maxFontSize: 18,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: AutoSizeText(
                              "BY",
                              minFontSize: 12,
                              maxFontSize: 20,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1),
                            ),
                          ),
                        ),
                        Expanded(
                          child: AutoSizeText(post["BookAuthor"]),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ));
    });
    setState(() {
      items = widgetItemsList;
    });
  }

  @override
  void initState() {
    super.initState();
    getListViewItems();
    listViewController.addListener(() {
      double value = listViewController.offset / 320;
      print(listViewController.offset);
      setState(() {
        topItem = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Card(
            margin: EdgeInsets.all(10),
            elevation: 10,
            color: Colors.white,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: AutoSizeText(
                          "GOOD EVENING",
                          maxFontSize: 20,
                          minFontSize: 12,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        fit: FlexFit.loose,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Flexible(
                        child: AutoSizeText(
                          "FAIZAN AHMAD",
                          maxFontSize: 16,
                          minFontSize: 12,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        fit: FlexFit.loose,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("images/profileicon.jpg"),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                color: purpleColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(5))),
            child: Padding(
              padding: EdgeInsets.only(left: 10, top: 5, right: 6),
              child: AutoSizeText(
                "RECOMMENDATIONS",
                maxLines: 1,
                minFontSize: 12,
                maxFontSize: 16,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: "Source Sans Pro",
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                color: purpleColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
              ),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
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
                      alignment: Alignment.centerRight,
                      child: items[index],
                    );
                  })),
        ),
        Expanded(
          flex: 12,
          child: Container(
              decoration: BoxDecoration(
                //  color: Colors.orange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        DashBoardItem(
                          text: "Check In",
                          onTap: () {
                            Navigator.pushNamed(context, "CheckInBooks");
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        DashBoardItem(text: "Check Out"),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Row(
                      children: [
                        DashBoardItem(text: "Books"),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        DashBoardItem(text: "Sales"),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Row(
                      children: [
                        DashBoardItem(text: "Out Of Stock"),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        DashBoardItem(text: "Recommendations"),
                      ],
                    ),
                  ],
                ),
              )),
        )
      ],
    ));
  }
}

class DashBoardItem extends StatelessWidget {
  DashBoardItem({this.text, this.onTap});
  String text;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.height * 0.1,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.grey[500], blurRadius: 10)],
            borderRadius: BorderRadius.circular(5),
            color: purpleColor,
          ),
          child: Center(
            child: AutoSizeText(
              text,
              minFontSize: 12,
              maxFontSize: 20,
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Source Sans Pro",
              ),
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
