import 'package:flutter/material.dart';
import 'package:we_book/constants.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {@required this.outsideText,
      @required this.hintText,
      @required this.icon,
      this.obscureText = false,
      this.keyboardType});
  final String outsideText;
  final String hintText;
  final IconData icon;
  bool obscureText;
  TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWitdh = size.width;
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
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              icon: Icon(icon),
            ),
          ),
        ),
      ],
    );
  }
}
