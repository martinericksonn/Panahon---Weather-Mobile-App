// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ThemeSelector {
  ThemeData themeSelector(context) {
    var dateNow = DateTime.now().hour;

    if (dateNow > 18) {
      return nightTheme();
    } else if (dateNow > 15) {
      return afternoonTheme();
    } else if (dateNow > 6) {
      return ThemeData();
    } else if (dateNow > 4) {
      return ThemeData();
    }
    return ThemeData();
  }

  ThemeData afternoonTheme() {
    return ThemeData(
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 0,
        color: Color.fromRGBO(255, 223, 148, .5),
      ),
      textTheme: const TextTheme(
        // labelMedium: TextStyle(color: Colors.white),
        // headline3: ,
        headline2: TextStyle(color: Color(0xff505050)),
        bodyText1: TextStyle(color: Color(0xff505050)),
        bodyText2: TextStyle(color: Color(0xff505050)),
        headline1: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        headline6: TextStyle(color: Colors.black, letterSpacing: 0.2),

        headline3: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      primaryColor: Colors.black,
    );
  }

  ThemeData nightTheme() {
    return ThemeData(
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 0,
        color: Color.fromRGBO(173, 173, 173, .5),
      ),
      textTheme: const TextTheme(
        // labelMedium: TextStyle(color: Colors.white),
        // headline3: ,
        // headline2: TextStyle(color: Color(0xff505050)),
        // bodyText1: TextStyle(color: Color(0xff505050)),
        bodyText2: TextStyle(
          color: Color(0xffCECECE),
        ),
        headline1: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        headline6: TextStyle(
          color: Colors.white,
          letterSpacing: 0.2,
        ),
        headline3: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        caption: TextStyle(
          color: Color(0xffCECECE),
        ),
      ),
      primaryColor: Colors.black,
    );
  }
}
