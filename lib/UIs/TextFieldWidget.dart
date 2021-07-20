import 'dart:async';

import 'package:flutter/material.dart';
import 'package:we_book/constants.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {@required this.outsideText,
      @required this.hintText,
      @required this.icon,
      this.obscureText = false,
      this.keyboardType,
      this.streamController,
      // this.textController,
      this.suffixIcon});
  final String outsideText;
  final String hintText;
  final IconData icon;
  IconButton suffixIcon;
  bool obscureText;
  var getValue = "";
  TextInputType keyboardType;
  StreamController<String> streamController;
  // TextEditingController textController;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //  double screenWitdh = size.width;
    double screenHeight = size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: screenHeight * 0.03,
        ),
        Text(
          outsideText,
          style: TextStyle(
            color: purpleColor,
          ),
        ),
        SizedBox(
          width: 0,
          height: screenHeight * 0.01,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey[300],
          ),
          child: TextField(
            // controller: textController,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              icon: Icon(icon),
              suffixIcon: suffixIcon,
            ),
            onChanged: (value) {
              streamController.add(value);
            },
          ),
        ),
      ],
    );
  }
}
