import 'package:flutter/material.dart';
import 'package:we_book/Screens/CommonScreens/UserProfile.dart';

class BookSellerProfile extends StatefulWidget {
  @override
  _BookSellerProfileState createState() => _BookSellerProfileState();
}

class _BookSellerProfileState extends State<BookSellerProfile> {
  @override
  Widget build(BuildContext context) {
    return UserProfile("Book Seller");
  }
}
