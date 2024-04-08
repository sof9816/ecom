import 'package:flutter/material.dart';

class AppColor {
  static var shared = AppColor();
  var greenColor = const Color(0xFF169CA1);
  var grayColor = const Color(0xFF1F2A34);
  var grayColor600 = const Color(0xFF273441);
  var smokeWhite = const Color(0xFFF8F8F8);
}

extension ColorExtension on String {
  Color toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse("0x$hexColor"));
  }
}
