import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Color(0xFF000a12);
  Color primaryColor = Color(0xFF263238);
  Color lightColor = Color(0xFF4f5b62);
  Color pinkColor = Color(0xFFc94f7c);
  Color lightpink = Color(0xFFf48fb1);

  TextStyle darkStyle() => TextStyle(color: darkColor);
  TextStyle lightStyle() => TextStyle(color: lightColor);
  TextStyle pinkStyle() => TextStyle(
        color: pinkColor,
        fontWeight: FontWeight.w700,
        fontSize: 14,
      );
  TextStyle signoutStyle() =>
      TextStyle(color: darkColor, fontWeight: FontWeight.bold);

  Widget showLogo() => Image(
        image: AssetImage('images/logo.png'),
      );

  SafeArea buildBackground(double screenWidth, double screenHeight) {
    return SafeArea(
      child: Container(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
            /*  children: [
            Positioned(
             top: 0,
              left: 0,
              child: Image(image: AssetImage('images/top1.png')),
              ),
              Positioned(
              top: 0,
              left: 0,
              child: Image(image: AssetImage('images/top2.png')),
              ),
              Positioned(
              bottom: 0,
              left: 0,
              child: Image(image: AssetImage('images/bottom1.png')),
              ),
              Positioned(
              bottom: 0,
              left: 0,
              child: Image(image: AssetImage('images/bottom2.png')),
              ),
          ],*/
            ),
      ),
    );
  }

  MyStyle();
}
