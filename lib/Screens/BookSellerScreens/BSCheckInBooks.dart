import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_book/Models/Books%20Detail/Book.dart';
import 'package:we_book/Models/PictureManagement/UploadDownloadImage.dart';
import 'package:we_book/UIs/PurpleRoundedButton.dart';
import 'package:we_book/constants.dart';

class CheckInBooks extends StatefulWidget {
  @override
  _CheckInBooksState createState() => _CheckInBooksState();
}

class _CheckInBooksState extends State<CheckInBooks> {
  FirebaseAuth firebaseAuth;
  String uid;
  File file;
  Book bookClassObject;
  String bookPushKey;
  TextEditingController _bookNameTextEditingController,
      _authorNameTextEditingController,
      _bookEditionTextEditingController,
      _initialBookPriceTextEditingController,
      _finalBookPriceTextEditingController,
      _bookQuantityTextEditingController,
      _shelfNameTextEditingController;


@override
  void dispose() {
    super.dispose();
    BotToast.closeAllLoading();
  }
  @override
  void initState() {
    
    super.initState();
    _bookNameTextEditingController = TextEditingController();
    _authorNameTextEditingController = TextEditingController();
    _bookEditionTextEditingController = TextEditingController();
    _initialBookPriceTextEditingController = TextEditingController();
    _finalBookPriceTextEditingController = TextEditingController();
    _bookQuantityTextEditingController = TextEditingController();
    _shelfNameTextEditingController = TextEditingController();
    firebaseAuth = FirebaseAuth.instance;
    uid = firebaseAuth.currentUser.uid;
    bookClassObject = Book();
  }

 String compareInitialFinalPrice() {
    String status;
    if (int.parse(_initialBookPriceTextEditingController.text) >=
        int.parse(_finalBookPriceTextEditingController.text)) {
      BotToast.showText(
          text: "Final price is lower than initial price",
          duration: Duration(seconds: 5));
      status = "Failure";
    } else {
      status= "Success";
    }

    return status;
  }

  String checkForEmptyTextFields() {
    String status;
    if (file == null) {
      BotToast.showText(
          text: "Please upload the image", duration: Duration(seconds: 3));
      return "Failure";
    }
    if (_bookNameTextEditingController.text.isEmpty ||
        _authorNameTextEditingController.text.isEmpty ||
        _bookEditionTextEditingController.text.isEmpty ||
        _initialBookPriceTextEditingController.text.isEmpty ||
        _finalBookPriceTextEditingController.text.isEmpty ||
        _bookQuantityTextEditingController.text.isEmpty ||
        _shelfNameTextEditingController.text.isEmpty) {
      BotToast.showText(
          text: "One of the fields is empty", duration: Duration(seconds: 3));
      status = "Failure";
    } else {
      status = "Success";
    }
    return status;
  }

  Future uploadBookImage() async {
    try {
      file = await UploadDownloadImage()
          .imagePicker()
          .whenComplete(() => setState(() {}));
    } catch (e) {
      print("Don't worry it's just an error BSCheckInBooks.dart");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                              ),
                              child: file == null
                                  ? Center(
                                      child: AutoSizeText(
                                        "Image",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Image.file(file),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: AutoSizeText(
                                      "Upload the book cover image",
                                      style: TextStyle(
                                        fontFamily: "Source Sans Pro",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: purpleColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    child: AutoSizeText(
                                      "Upload",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Source Sans Pro",
                                      ),
                                    ),
                                    onPressed: () {
                                      uploadBookImage();
                                    },
                                  ),
                                ),
                                Expanded(child: Container()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                  child: MyCardTextField(
                    outsideText: "Book Name",
                    prefixIcon: FontAwesomeIcons.book,
                    textEditingController: _bookNameTextEditingController,
                  ),
                ),
                Expanded(
                  child: MyCardTextField(
                    outsideText: "Author Name",
                    prefixIcon: FontAwesomeIcons.user,
                    textEditingController: _authorNameTextEditingController,
                  ),
                ),
                Expanded(
                  child: MyCardTextField(
                    outsideText: "Book Edition",
                    keyboardType: TextInputType.number,
                    prefixIcon: FontAwesomeIcons.sortNumericDown,
                    textEditingController: _bookEditionTextEditingController,
                  ),
                ),
                Expanded(
                  child: MyCardTextField(
                    outsideText: "Initial Book Price",
                    keyboardType: TextInputType.number,
                    prefixIcon: FontAwesomeIcons.fileInvoiceDollar,
                    textEditingController:
                        _initialBookPriceTextEditingController,
                  ),
                ),
                Expanded(
                  child: MyCardTextField(
                    outsideText: "Final Book Price",
                    keyboardType: TextInputType.number,
                    prefixIcon: FontAwesomeIcons.fileInvoiceDollar,
                    textEditingController: _finalBookPriceTextEditingController,
                  ),
                ),
                Expanded(
                  child: MyCardTextField(
                    outsideText: "Quantity",
                    keyboardType: TextInputType.number,
                    prefixIcon: FontAwesomeIcons.sort,
                    textEditingController: _bookQuantityTextEditingController,
                  ),
                ),
                Expanded(
                  child: MyCardTextField(
                    outsideText: "Shelf Name/Number",
                    prefixIcon: FontAwesomeIcons.slidersH,
                    textEditingController: _shelfNameTextEditingController,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Expanded(
                  child: PurpleRoundButton(
                    buttonHeight: 0.2,
                    buttonWidth: 0.5,
                    buttonText: "SAVE",
                    onPressed: () async {
                      if (checkForEmptyTextFields() == "Success" && compareInitialFinalPrice()=="Success") {
                        await bookClassObject
                            .checkInBook(
                                bookName: _bookNameTextEditingController.text,
                                authorName:
                                    _authorNameTextEditingController.text,
                                bookEdition:
                                int.parse(_bookEditionTextEditingController.text),
                                initialBookPrice:
                                    int.parse(_initialBookPriceTextEditingController.text),
                                finalBookPrice:
                                    int.parse(_finalBookPriceTextEditingController.text),
                                bookQuantity:
                                    int.parse(_bookQuantityTextEditingController.text),
                                bookShelf: _shelfNameTextEditingController.text)
                            .then((bookPushKey) {
                          if (bookPushKey != "Failure") {
                            this.bookPushKey = bookPushKey;
                            return UploadDownloadImage()
                                .uploadImageToFirebaseStorage(file,
                                    "Book Seller/$uid/Books", bookPushKey);
                          }
                        }).then((bookPictureUrl) {
                          if (bookPictureUrl != "nothing") {
                            return bookClassObject.updateBookPictureURL(
                                url: bookPictureUrl,
                                uid: uid,
                                bookPushKey: bookPushKey);
                          }
                        }).then((status) {
                          if (status == "Success") {
                            BotToast.showText(text: "New Book Added");
                            Navigator.pop(context);
                          } else {
                            BotToast.showText(
                                text:
                                    "Unable to upload book details BSCheckInBooks.dart");
                            print(
                                "Unable to upload book details BSCheckInBooks.dart");
                          }
                        });
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class MyCardTextField extends StatefulWidget {
  MyCardTextField(
      {this.textEditingController,
      this.outsideText = "",
      this.keyboardType = TextInputType.text,
      this.prefixIcon});
  TextEditingController textEditingController;
  String outsideText;
  TextInputType keyboardType;
  IconData prefixIcon;

  @override
  _MyCardTextFieldState createState() => _MyCardTextFieldState();
}

class _MyCardTextFieldState extends State<MyCardTextField> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.white,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Icon(
                  widget.prefixIcon,
                )),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: AutoSizeText(
                      widget.outsideText,
                      maxLines: 1,
                      maxFontSize: 16,
                      minFontSize: 6,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Source Sans Pro",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: TextField(
                        decoration: InputDecoration(),
                        maxLines: 1,
                        controller: widget.textEditingController,
                        keyboardType: widget.keyboardType,
                        obscureText: false,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
