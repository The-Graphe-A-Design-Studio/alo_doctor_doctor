import 'package:flutter/material.dart';

class Styles {
  static const regularHeading = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black);

  static const boldHeading = TextStyle(
      fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.black);

  static const buttonTextBlack = TextStyle(fontSize: 16.0, color: Colors.black);

  static const buttonTextBlackBold = TextStyle(
    fontSize: 16.0,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );

  static var regularGreyText =
      TextStyle(fontSize: 15.0, color: Colors.grey.shade600);

  static const buttonTextWhite = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white);

  static const regularErrorHeading = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.redAccent);
}
