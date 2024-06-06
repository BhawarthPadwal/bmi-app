import 'package:flutter/material.dart';

const Color blackColor = Colors.black;
const Color transparentColor = Colors.transparent;
const Color orangeColor = Colors.orangeAccent;
const Color whiteColor = Colors.white;
const Color paleGreenColor = Color(0xffbbdb44);
const Color greenColor = Color(0xff44ce1b);
const Color chromeColor = Color(0xfff2a134);
const Color redColor = Color(0xffe51f1f);

const double padding18 = 18.0;
const double padding16 = 16.0;
const double padding14 = 14.0;
const double padding12 = 12.0;
const double padding10 = 10.0;
const double padding20 = 20.0;
const double padding30 = 30.0;
const double padding50 = 50.0;
const double padding60 = 60.0;

SizedBox heightBox(double height) {
  return SizedBox(height: height);
}

TextStyle kCustomTextStyle(Color color, double size, bool isBold) {
  return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
      fontFamily: 'Poppins');
}

TextStyle kLabelTextStyle(double size) {
  return TextStyle(fontSize: size, fontFamily: 'Poppins');
}
