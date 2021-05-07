import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyAwesomeTextField extends StatefulWidget {
  MyAwesomeTextField(
      {this.shopNameController,
      this.outsideText,
      this.keyboardType = TextInputType.text});
  TextEditingController shopNameController;
  String outsideText;
  TextInputType keyboardType;

  @override
  _MyAwesomeTextFieldState createState() => _MyAwesomeTextFieldState();
}

class _MyAwesomeTextFieldState extends State<MyAwesomeTextField> {
  String insideText;
  bool firstTime;
  @override
  void initState() {
    super.initState();
    firstTime = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                minFontSize: 6,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Source Sans Pro",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
                top: 29,
                bottom: 5,
                left: 20,
                right: 20,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 1,
                  controller: widget.shopNameController,
                  keyboardType: widget.keyboardType,
                  obscureText: false,
                  showCursor: true,
                  onTap: () {
                    if (firstTime == true) {
                      insideText = widget.shopNameController.text;
                      firstTime = false;
                    }
                  },
                )),
            Positioned(
                top: 30,
                right: 20,
                bottom: 6,
                child: IconButton(
                  alignment: Alignment.centerRight,
                  iconSize: 15,
                  icon: Icon(FontAwesomeIcons.undo),
                  onPressed: () {
                    widget.shopNameController.text = insideText;
                  },
                ))
          ],
        )),
      ],
    );
  }
}
