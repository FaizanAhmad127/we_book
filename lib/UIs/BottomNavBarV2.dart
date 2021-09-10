import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_book/Provider%20ChangeNotifiers/BSBottomNavBarCN.dart';
import 'package:we_book/constants.dart';

class BottomNavBarV2 extends StatefulWidget {
  @override
  _BottomNavBarV2State createState() => _BottomNavBarV2State();
}

class _BottomNavBarV2State extends State<BottomNavBarV2> {
  int currentIndex = 0;
  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: 80,
          child: Stack(
            overflow: Overflow.visible,
            children: [
              CustomPaint(
                size: Size(size.width, 80),
                painter: BNBCustomPainter(),
              ),
              Center(
                heightFactor: 0.6,
                child: FloatingActionButton(
                    backgroundColor: purpleColor,
                    child: FaIcon(FontAwesomeIcons.qrcode),
                    elevation: 0.1,
                    onPressed: () {
                      Navigator.pushNamed(context, "BSQRScanner");
                    }),
              ),
              Container(
                width: size.width,
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.home,
                            color:
                                currentIndex == 0 ? purpleColor : Colors.white,
                          ),
                          onPressed: () {
                            setBottomBarIndex(0);
                            Provider.of<BSBottomNavBarCN>(context,
                                    listen: false)
                                .setHomeScreen = true;
                          },
                          splashColor: Colors.white,
                        ),
                        AutoSizeText(
                          "HOME",
                          minFontSize: 8,
                          maxFontSize: 12,
                          maxLines: 1,
                          style: TextStyle(
                              color: currentIndex == 0
                                  ? purpleColor
                                  : Colors.white,
                              fontSize: 12,
                              letterSpacing: 0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: Icon(
                              FontAwesomeIcons.commentDollar,
                              color: currentIndex == 1
                                  ? purpleColor
                                  : Colors.white,
                            ),
                            onPressed: () {
                              setBottomBarIndex(1);
                              Provider.of<BSBottomNavBarCN>(context,
                                      listen: false)
                                  .setTransactionScreen = true;
                            }),
                        AutoSizeText(
                          "TRANSACTIONS",
                          minFontSize: 8,
                          maxFontSize: 12,
                          maxLines: 1,
                          style: TextStyle(
                              color: currentIndex == 1
                                  ? purpleColor
                                  : Colors.white,
                              fontSize: 12,
                              letterSpacing: 0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Container(
                      width: size.width * 0.20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: Icon(
                              FontAwesomeIcons.warehouse,
                              color: currentIndex == 2
                                  ? purpleColor
                                  : Colors.white,
                            ),
                            onPressed: () {
                              setBottomBarIndex(2);
                              Provider.of<BSBottomNavBarCN>(context,
                                      listen: false)
                                  .setShopScreen = true;
                            }),
                        AutoSizeText(
                          "MY SHOP",
                          minFontSize: 8,
                          maxFontSize: 12,
                          maxLines: 1,
                          style: TextStyle(
                              color: currentIndex == 2
                                  ? purpleColor
                                  : Colors.white,
                              fontSize: 12,
                              letterSpacing: 0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: Icon(
                              FontAwesomeIcons.userAstronaut,
                              color: currentIndex == 3
                                  ? purpleColor
                                  : Colors.white,
                            ),
                            onPressed: () {
                              setBottomBarIndex(3);
                              Provider.of<BSBottomNavBarCN>(context,
                                      listen: false)
                                  .setProfileScreen = true;
                            }),
                        AutoSizeText(
                          "PROFILE",
                          minFontSize: 8,
                          maxFontSize: 12,
                          maxLines: 1,
                          style: TextStyle(
                              color: currentIndex == 3
                                  ? purpleColor
                                  : Colors.white,
                              fontSize: 12,
                              letterSpacing: 0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
