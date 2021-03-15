import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CheckInBooks extends StatefulWidget {
  @override
  _CheckInBooksState createState() => _CheckInBooksState();
}

class _CheckInBooksState extends State<CheckInBooks> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: MyAwesomeTextField(),
    ));
  }
}

class MyAwesomeTextField extends StatefulWidget {
  MyAwesomeTextField(
      {this.shopNameController,
      this.outsideText = "",
      this.keyboardType = TextInputType.text});
  TextEditingController shopNameController;
  String outsideText;
  TextInputType keyboardType;

  @override
  _MyAwesomeTextFieldState createState() => _MyAwesomeTextFieldState();
}

class _MyAwesomeTextFieldState extends State<MyAwesomeTextField> {
  bool readOnly = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 20,
              child: AutoSizeText(
                widget.outsideText,
                maxLines: 1,
                maxFontSize: 16,
                minFontSize: 12,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Source Sans Pro",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
                top: 25,
                left: 20,
                right: 20,
                child: TextField(
                  maxLines: 1,
                  controller: widget.shopNameController,
                  keyboardType: widget.keyboardType,
                  obscureText: false,
                  enabled: readOnly,
                )),
            Positioned(
                top: 25,
                right: 20,
                child: IconButton(
                  icon: Icon(FontAwesomeIcons.solidEdit),
                  onPressed: () {
                    setState(() {
                      readOnly = readOnly == true ? false : true;
                    });
                  },
                ))
          ],
        )),
      ],
    );
  }
}
