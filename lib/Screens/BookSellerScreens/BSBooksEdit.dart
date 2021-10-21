import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_book/Models/Books%20Detail/Book.dart';
import 'package:we_book/Models/PictureManagement/UploadDownloadImage.dart';
import 'package:we_book/UIs/PurpleRoundedButton.dart';
import 'package:we_book/constants.dart';

class BSBooksEdit extends StatefulWidget {
  String imagePath,
      BookName,
      AuthorName,
      BookEdition,
      InitialPrice,
      FinalPrice,
      Quantity,
      ShelfName,
      bookPushKey;

  BSBooksEdit(
      {this.imagePath,
      this.BookName,
      this.AuthorName,
      this.BookEdition,
      this.InitialPrice,
      this.FinalPrice,
      this.Quantity,
      this.ShelfName,
      this.bookPushKey});
  @override
  _BSBooksEditState createState() => _BSBooksEditState();
}

class _BSBooksEditState extends State<BSBooksEdit> {
  TextEditingController bookNameController,
      authorNameController,
      bookEditionController,
      initialPriceController,
      finalPriceController,
      quantityController,
      shelfNameController;
  File file;
  Book bookClassObject;

  FirebaseAuth firebaseAuth;
  String uid;


@override
  void dispose() {
    super.dispose();
    BotToast.closeAllLoading();
  }
  @override
  void initState() {
    super.initState();
    bookNameController = TextEditingController(text: widget.BookName);
    authorNameController = TextEditingController(text: widget.AuthorName);
    bookEditionController = TextEditingController(text: widget.BookEdition);
    initialPriceController = TextEditingController(text: widget.InitialPrice);
    finalPriceController = TextEditingController(text: widget.FinalPrice);
    quantityController = TextEditingController(text: widget.Quantity);
    shelfNameController = TextEditingController(text: widget.ShelfName);

    bookClassObject = Book();
    firebaseAuth = FirebaseAuth.instance;
    uid = firebaseAuth.currentUser.uid;
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

  String compareInitialFinalPrice() {
    String status;
    if (int.parse(initialPriceController.text) >=
        int.parse(finalPriceController.text)) {
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
    if (file == null && widget.imagePath == null) {
      BotToast.showText(
          text: "Please upload the image", duration: Duration(seconds: 3));
      return "Failure";
    }
    if (bookNameController.text.isEmpty ||
        authorNameController.text.isEmpty ||
        bookEditionController.text.isEmpty ||
        initialPriceController.text.isEmpty ||
        finalPriceController.text.isEmpty ||
        quantityController.text.isEmpty ||
        shelfNameController.text.isEmpty) {
      BotToast.showText(
          text: "One of the fields is empty", duration: Duration(seconds: 3));
      status = "Failure";
    } else {
      status = "Success";
    }
    return status;
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
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                              ),
                              child: file == null
                                  ? CachedNetworkImage(
                                      imageUrl: widget.imagePath,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                        Icons.error,
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
                    textEditingController: bookNameController,
                  ),
                ),
                Expanded(
                  child: MyCardTextField(
                    outsideText: "Author Name",
                    prefixIcon: FontAwesomeIcons.user,
                    textEditingController: authorNameController,
                  ),
                ),
                Expanded(
                  child: MyCardTextField(
                    outsideText: "Book Edition",
                    keyboardType: TextInputType.number,
                    prefixIcon: FontAwesomeIcons.sortNumericDown,
                    textEditingController: bookEditionController,
                  ),
                ),
                Expanded(
                  child: MyCardTextField(
                    outsideText: "Initial Book Price",
                    keyboardType: TextInputType.number,
                    prefixIcon: FontAwesomeIcons.fileInvoiceDollar,
                    textEditingController: initialPriceController,
                  ),
                ),
                Expanded(
                  child: MyCardTextField(
                    outsideText: "Final Book Price",
                    keyboardType: TextInputType.number,
                    prefixIcon: FontAwesomeIcons.fileInvoiceDollar,
                    textEditingController: finalPriceController,
                  ),
                ),
                Expanded(
                  child: MyCardTextField(
                    outsideText: "Quantity",
                    keyboardType: TextInputType.number,
                    prefixIcon: FontAwesomeIcons.sort,
                    textEditingController: quantityController,
                  ),
                ),
                Expanded(
                  child: MyCardTextField(
                    outsideText: "Shelf Name/Number",
                    prefixIcon: FontAwesomeIcons.slidersH,
                    textEditingController: shelfNameController,
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
                                bookName: bookNameController.text,
                                authorName: authorNameController.text,
                                bookEdition:
                                    int.parse(bookEditionController.text),
                                initialBookPrice:
                                    int.parse(initialPriceController.text),
                                finalBookPrice:
                                    int.parse(finalPriceController.text),
                                bookQuantity:
                                    int.parse(quantityController.text),
                                bookShelf: shelfNameController.text,
                                editBookKey: widget.bookPushKey)

                            //now we will upload the edited image to firebase storage
                            //and update the url to realtime database
                            //if the image is not updated then we will use the previous image
                            .then((bookPushkey) {
                          if (bookPushkey != "Failure") {
                            //checking if user edited the file or not
                            if (file != null) {
                              // this.bookPushKey = bookPushKey;
                              return UploadDownloadImage() // upload book to firebase storage and return the link
                                  .uploadImageToFirebaseStorage(file,
                                      "Book Seller/$uid/Books", bookPushkey)
                                  //we will now edit the image url in realtime database
                                  .then((bookPictureUrl) {
                                if (bookPictureUrl != "nothing") {
                                  return bookClassObject.updateBookPictureURL(
                                      // returned link will be saved in realtime database
                                      url: bookPictureUrl,
                                      uid: uid,
                                      bookPushKey: bookPushkey);
                                }
                                // if the image link is edited successfully in realtimed database
                              }).then((status) {
                                if (status == "Success") {
                                  BotToast.showText(text: "Book is edited");
                                } else {
                                  BotToast.showText(
                                      text:
                                          "Unable to edit book image BSCheckInBooks.dart");
                                  print(
                                      "Unable to edit book image BSCheckInBooks.dart");
                                }
                              });
                            }
                          } else {
                            BotToast.showText(
                                text: "Unable to edit book details");
                          }
                          Navigator.pop(context);
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
  bool isEnabled = false;
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
                        enabled: isEnabled,
                      )),
                ],
              ),
            ),
            Expanded(
                child: IconButton(
              icon: Icon(FontAwesomeIcons.edit),
              iconSize: 20,
              color: purpleColor,
              onPressed: () {
                setState(() {
                  isEnabled ? isEnabled = false : isEnabled = true;
                });
              },
            ))
          ],
        ),
      ),
    );
  }
}
