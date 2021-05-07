import 'package:flutter/material.dart';
import 'package:we_book/screens/BookBuyerProfile.dart';

class BookSellerProfile extends StatefulWidget {
  @override
  _BookSellerProfileState createState() => _BookSellerProfileState();
}

class _BookSellerProfileState extends State<BookSellerProfile> {
  @override
  Widget build(BuildContext context) {
    return BookBuyerProfile("Book Seller");
  }
}
