import 'package:flutter/material.dart';
import 'package:we_book/constants.dart';

class PurpleRoundButton extends StatelessWidget {
  PurpleRoundButton(
      {@required this.buttonText,
      @required this.buttonHeight,
      @required this.buttonWidth,
      @required this.onPressed});
  final String buttonText;
  final double buttonHeight;
  final double buttonWidth;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * buttonHeight,
      width: MediaQuery.of(context).size.width * buttonWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          primary: purpleColor,
          elevation: 3,
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white, fontFamily: "Source Sans Pro"),
        ),
      ),
    );
  }
}
