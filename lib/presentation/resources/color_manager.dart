import 'package:flutter/material.dart';

class ColorManager {
  //static Color primary = HexColor.fromHex("#EB0404");
  //static Color background = HexColor.fromHex("#FAEBEB");

  static Color primary = HexColor.fromHex("#6B41B8");
  static Color background = HexColor.fromHex("#EFEBF9");
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color primaryOpacity70 = HexColor.fromHex("#B3ED9728");

  //dark
  static Color dakPrimary = HexColor.fromHex("#00008B");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color error = HexColor.fromHex("#e61f34");

  static Color black = HexColor.fromHex("#000000");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF' + hexColorString; // 8 char with opacity 100%
    }
    //print(int.parse(hexColorString, radix: 16));
    return Color(int.parse(hexColorString, radix: 16));
  }
}
