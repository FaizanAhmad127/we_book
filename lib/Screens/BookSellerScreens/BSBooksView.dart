import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_book/Models/Books%20Detail/Book.dart';
import 'package:we_book/Screens/BookSellerScreens/BSBooksEdit.dart';
import 'package:we_book/constants.dart';

class BSBooksView extends StatefulWidget {
  @override
  _BSBooksViewState createState() => _BSBooksViewState();
}

class _BSBooksViewState extends State<BSBooksView> {
  List<dynamic> items = [];
  ScrollController listViewController = ScrollController();
  double topItem = 0;
  double opacity;
  String searchString = "";
  TextEditingController searchTextFieldController = TextEditingController();
  Book book;

  Widget listItem(String key, dynamic post) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 150,
        child: Card(
          // margin: EdgeInsets.all(10),
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
                              image: imageProvider, fit: BoxFit.cover),
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
                                "Initial Price:  ${post["finalBookPrice"]}",
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
              VerticalDivider(
                width: 3,
                indent: 5,
                endIndent: 5,
                thickness: 2,
                color: Colors.black,
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: IconButton(
                      icon: Icon(FontAwesomeIcons.edit),
                      color: purpleColor,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BSBooksEdit(
                                      imagePath: post["bookImage"],
                                      BookName: post["bookName"],
                                      AuthorName: post["authorName"],
                                      BookEdition:
                                          post["bookEdition"].toString(),
                                      InitialPrice:
                                          post["initialBookPrice"].toString(),
                                      FinalPrice:
                                          post["finalBookPrice"].toString(),
                                      ShelfName: post["bookShelf"],
                                      Quantity: post["bookQuantity"].toString(),
                                      bookPushKey: key,
                                    ))).then((_) => setState(() {
                              getListViewItems(); // after editing on editing screen and when we come back to
                              // book view screen we have to update or show the edited changes
                            }));
                      },
                    )),
                    Expanded(
                        child: IconButton(
                      icon: Icon(Icons.delete),
                      color: purpleColor,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              "Delete ${post["bookName"]}",
                            ),
                            titlePadding: EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            content: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.03,
                              child: Column(
                                children: [
                                  Expanded(
                                      child: AutoSizeText("Are you SURE?")),
                                ],
                              ),
                            ),
                            actions: [
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: purpleColor,
                                  ),
                                  child: Text(
                                    "Delete",
                                  ),
                                  onPressed: () async { 
                                    String status = await book.deleteBook(key);// first we will delete the asked book node using it's unique key
                                    if (status == "Success") {
                                      status = await book
                                          .deleteBookPictureFromFirebaseStorage(
                                              key); // second we will delete the image of book from firebase storage.
                                      if (status == "Success") {
                                        BotToast.showText(
                                            text:
                                                "Book is successfully deleted");
                                        getListViewItems();
                                      }
                                      
                                    } else {
                                      BotToast.showText(
                                          text: "Unable to delete book");
                                    }
                                    Navigator.pop(context);
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )),
                  ],
                ),
              ))
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
        responseList.forEach((key, post) {
          searchString = searchString.toUpperCase();
          String bookName = post["bookName"].toString().toUpperCase();
          if (searchString.isNotEmpty) {
            if (bookName.contains(searchString)) {
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

  @override
  void initState() {
    // TODO: implement initState
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
                      opacity = 1;
                      if (topItem > 0) {
                        scale = index + 1 - topItem;
                        opacity = scale;
                        if (scale < 0) {
                          scale = 0;
                          opacity = scale;
                        } else if (scale > 1) {
                          scale = 1;
                          opacity = scale;
                        }
                      }
                      return AnimatedOpacity(
                        duration: Duration(milliseconds: 100),
                        opacity: opacity,
                        child: Transform(
                          transform: Matrix4.identity()..scale(scale, scale),
                          alignment: Alignment.topCenter,
                          child: items[index],
                        ),
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
