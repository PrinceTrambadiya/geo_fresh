import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

MaterialColor primaryColor = MaterialColor(0xFF328B5B, color);
Map<int, Color> color = {
  50: Color.fromRGBO(27, 42, 103, .1),
  100: Color.fromRGBO(27, 42, 103, .2),
  200: Color.fromRGBO(27, 42, 103, .3),
  300: Color.fromRGBO(27, 42, 103, .4),
  400: Color.fromRGBO(27, 42, 103, .5),
  500: Color.fromRGBO(27, 42, 103, .6),
  600: Color.fromRGBO(27, 42, 103, .7),
  700: Color.fromRGBO(27, 42, 103, .8),
  800: Color.fromRGBO(27, 42, 103, .9),
  900: Color.fromRGBO(27, 42, 103, 1),
};

Color greenColor = HexColor('#328B5B');
Color greyColor = HexColor('#EBECF0');
Color whiteColor = HexColor('#FFFFFF');
Color lightBlackColor = HexColor('#2D3037');
Color textFieldColor = HexColor('#F8F9FF');
Color blackColor = Colors.black;
Color redColor = Colors.red;
Color blueColor = Colors.blue;
Color transparentColor = Colors.transparent;
