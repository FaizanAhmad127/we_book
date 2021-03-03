import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:we_book/Provider%20ChangeNotifiers/BottomNavBarCN.dart';

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
                    backgroundColor: Colors.orange,
                    child: FaIcon(FontAwesomeIcons.qrcode),
                    elevation: 0.1,
                    onPressed: () {}),
              ),
              Container(
                width: size.width,
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.home,
                        color: currentIndex == 0
                            ? Colors.orange
                            : Colors.grey.shade400,
                      ),
                      onPressed: () {
                        setBottomBarIndex(0);
                        Provider.of<BottomNavBarCN>(context, listen: false)
                            .setHomeScreen = true;
                      },
                      splashColor: Colors.white,
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.restaurant_menu,
                          color: currentIndex == 1
                              ? Colors.orange
                              : Colors.grey.shade400,
                        ),
                        onPressed: () {
                          setBottomBarIndex(1);
                        }),
                    Container(
                      width: size.width * 0.20,
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.bookmark,
                          color: currentIndex == 2
                              ? Colors.orange
                              : Colors.grey.shade400,
                        ),
                        onPressed: () {
                          setBottomBarIndex(2);
                        }),
                    IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.user,
                          color: currentIndex == 3
                              ? Colors.orange
                              : Colors.grey.shade400,
                        ),
                        onPressed: () {
                          setBottomBarIndex(3);
                          Provider.of<BottomNavBarCN>(context, listen: false)
                              .setProfileScreen = true;
                        }),
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
      ..color = Colors.white
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
