import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      ShelfName;
  BSBooksEdit(
      {this.imagePath,
      this.BookName,
      this.AuthorName,
      this.BookEdition,
      this.InitialPrice,
      this.FinalPrice,
      this.Quantity,
      this.ShelfName});
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
  String imagePath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookNameController = TextEditingController(text: widget.BookName);
    authorNameController = TextEditingController(text: widget.AuthorName);
    bookEditionController = TextEditingController(text: widget.BookEdition);
    initialPriceController = TextEditingController(text: widget.InitialPrice);
    finalPriceController = TextEditingController(text: widget.FinalPrice);
    quantityController = TextEditingController(text: widget.Quantity);
    shelfNameController = TextEditingController(text: widget.ShelfName);
    imagePath = widget.imagePath;
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
                              child: Image.asset(
                                "images/$imagePath",
                              ),
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
                                  child: RaisedButton(
                                    color: purpleColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: AutoSizeText(
                                      "Upload",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Source Sans Pro",
                                      ),
                                    ),
                                    onPressed: () {},
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
                    onPressed: () {
                      Navigator.pop(context);
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
