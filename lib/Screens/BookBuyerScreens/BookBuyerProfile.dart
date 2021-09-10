import 'package:flutter/material.dart';
import 'package:we_book/Screens/CommonScreens/UserProfile.dart';

class BookBuyerProfile extends StatefulWidget {
  @override
  _BookBuyerProfileState createState() => _BookBuyerProfileState();
}

class _BookBuyerProfileState extends State<BookBuyerProfile> {
  @override
  Widget build(BuildContext context) {
    return UserProfile("Book Buyer");
  }
}
