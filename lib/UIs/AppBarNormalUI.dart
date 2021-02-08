import 'package:flutter/material.dart';
import 'package:we_book/constants.dart';

class AppBarNormalUI {
  AppBar myAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: blackColor,
      leading: Image(
        image: AssetImage('images/webooklogo.jpg'),
      ),
      title: Text(
        "The Book Finder App",
        style: webooktextStyle,
      ),
    );
  }
}
