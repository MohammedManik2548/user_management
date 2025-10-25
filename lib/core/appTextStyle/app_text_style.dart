import 'package:flutter/material.dart';


class AppTextStyle {

  static TextStyle newTextStyle(
      {required double fontSize, Color? color,required FontWeight fontWeight}) {
    return TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: TextDecoration.none
    );
  }

}