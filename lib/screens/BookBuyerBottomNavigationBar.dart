import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:we_book/constants.dart';

class BookBuyerBottomNavigationBar extends StatefulWidget {
  @override
  _BookBuyerBottomNavigationBarState createState() =>
      _BookBuyerBottomNavigationBarState();
}

class _BookBuyerBottomNavigationBarState
    extends State<BookBuyerBottomNavigationBar> {
  int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return FFNavigationBar(
      theme: FFNavigationBarTheme(
        barBackgroundColor: blackColor,
        selectedItemBorderColor: Colors.yellow,
        selectedItemBackgroundColor: Colors.white,
        selectedItemIconColor: purpleColor,
        selectedItemLabelColor: Colors.white,
      ),
      selectedIndex: selectedIndex,
      onSelectTab: (index) {
        setState(() {
          selectedIndex = index;
        });
        if (selectedIndex == 2) {
          Navigator.pushNamed(context, "BookBuyerProfile");
        }
      },
      items: [
        FFNavigationBarItem(
          iconData: Icons.shopping_cart,
          label: 'Cart',
        ),
        FFNavigationBarItem(
          iconData: Icons.qr_code_outlined,
          label: 'QR Codes',
        ),
        FFNavigationBarItem(
          iconData: Icons.account_circle,
          label: 'Faizan',
        ),
      ],
    );
  }
}
