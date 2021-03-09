import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:we_book/Provider%20ChangeNotifiers/BBBottomNavBarCN.dart';
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
          Provider.of<BBBottomNavBarCN>(context, listen: false)
              .setProfileScreen = true;
          ;
        } else if (selectedIndex == 0) {
          Provider.of<BBBottomNavBarCN>(context, listen: false).setHomeScreen =
              true;
        }
      },
      items: [
        FFNavigationBarItem(
          iconData: FontAwesomeIcons.home,
          label: 'Home',
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
