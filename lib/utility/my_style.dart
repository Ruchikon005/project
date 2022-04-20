import 'package:flutter/material.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:google_fonts/google_fonts.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

class MyStyle {
  Color darkColor = Colors.black54;
  Color whiteColor = Colors.white;
  MaterialColor colorCustom = MaterialColor(0xFFA16B34, color);
  Color primryColor = Colors.amber.shade400;
  Color buttonRegisterColor = Colors.lightGreen;
  Color errorBorder = Colors.red;

  BorderRadius borderRadius = BorderRadius.all(Radius.circular(20.0));

  SizedBox mySizeBox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  // Text showTitle(String title) {
  //     return Text(
  //       title,
  //       style: TextStyle(
  //         fontSize: 24.0,
  //         color: Colors.amber.shade400,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     );

  // }

  Text showTextRegister(String register) {
    return Text(
      register,
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  //method highLightTitle //สำหรับเปลี่ยนสีตัวอักษรบางตัวใน String
  Directionality highLightTitle(String title) {
    return Directionality(
        child: SubstringHighlight(
          text: title,
          term: 'O',
          textStyle: TextStyle(
            fontSize: 24.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          // highlight style
          textStyleHighlight: TextStyle(
            fontSize: 24.0,
            color: Colors.amber.shade400,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr);
  }

  //method highLightTitle //สำหรับเปลี่ยนสีตัวอักษรบางตัวใน String
  Directionality highLightSlpash(String title) {
    return Directionality(
        child: SubstringHighlight(
          text: title,
          term: 'O',
          textStyle: GoogleFonts.luckiestGuy(
            letterSpacing: 5,
            fontSize: 60.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          // highlight style
          textStyleHighlight: GoogleFonts.luckiestGuy(
            letterSpacing: 5,
            fontSize: 65.0,
            color: Colors.amber.shade400,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr);
  }

  //method showlogo
  Container showLogo() {
    return Container(
      width: 120.0,
      child: Image.asset('images/icon_i.png'),
    );
  }
  Container showLogoSplash() {
    return Container(
      width: 600.0,
      child: Image.asset('images/iconkhnom.png'),
    );
  }

  //constructor
  MyStyle();
}
