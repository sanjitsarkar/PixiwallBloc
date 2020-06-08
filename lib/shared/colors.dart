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

Color Primary = HexColor('121E2F');
Color Secondary = HexColor('#242B45');
Color Accent = HexColor('#404864');
Color blue1 = HexColor('#21E978');
Color blue2 = HexColor('#2E41BA');
Color blue3 = HexColor('#6AF9FF');
Color blue4  =HexColor('#22549F');
Color orange1 = HexColor('#FFAD0A');
Color purple = HexColor('#C215B1');
Color red1 = HexColor('#FF0A0A');
Color red2 = HexColor('#C21577');
Color black1 = HexColor('#404864');
Color black2 = HexColor('#939CB8');
// Color blue5 = HexColor('#6AF9FF');
// Color blue6 = HexColor('#22549F');
Color shadowColor = HexColor('#000000').withOpacity(.16);
Gradient grad1 = LinearGradient(colors: [blue1,blue2],begin:Alignment.topCenter,end: Alignment.bottomCenter);

Gradient grad2 = LinearGradient(colors: [blue3,blue4],begin:Alignment.topCenter,end: Alignment.bottomCenter);

Gradient grad3 = LinearGradient(colors: [orange1,purple],begin:Alignment.topCenter,end: Alignment.bottomCenter);
Gradient grad4 = LinearGradient(colors: [red1,red2],begin:Alignment.topCenter,end: Alignment.bottomCenter);
Gradient grad5 = LinearGradient(colors: [black1,black2],begin:Alignment.topCenter,end: Alignment.bottomCenter);
Gradient grad6 = LinearGradient(colors: [black1.withOpacity(.5),black2.withOpacity(.5)],begin:Alignment.topCenter,end: Alignment.bottomCenter);