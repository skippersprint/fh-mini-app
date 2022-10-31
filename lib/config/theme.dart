import 'dart:ui';

import 'package:flutter/material.dart';

const textColor = Color.fromARGB(255, 61, 61, 61);
double screenHeight = window.physicalSize.height;

var myAppTheme = ThemeData(
    colorScheme: const ColorScheme(
      primary: Color.fromARGB(255, 61, 61, 61),
      secondary: Color.fromARGB(255, 162, 164, 170),
      error: Color.fromARGB(183, 255, 43, 28),
      surface: Color.fromRGBO(255, 255, 255, 1.0),
      onPrimary: Color.fromRGBO(255, 255, 255, 1.0),
      background: Color.fromRGBO(198, 218, 231, 1.0),
      onSecondary: Color.fromRGBO(255, 255, 255, 1.0),
      onError: Color.fromRGBO(255, 255, 255, 1.0),
      brightness: Brightness.light,
      onBackground: Color(0x000000FF),
      onSurface: Color(0x000000FF),
    ),
    textTheme: screenHeight < 1000 ? textThemeSmall : textThemeDefault,
    fontFamily: 'Poppins');

    var myAppThemeDark = ThemeData(
    colorScheme: const ColorScheme(
      primary: Color.fromARGB(255, 224, 224, 224),
      secondary: Color.fromARGB(255, 162, 164, 170),
      error: Color.fromARGB(183, 255, 28, 28),
      surface: Color.fromRGBO(255, 255, 255, 1.0),
      onPrimary: Color.fromRGBO(255, 255, 255, 1.0),
      background: Color.fromRGBO(198, 218, 231, 1.0),
      onSecondary: Color.fromRGBO(255, 255, 255, 1.0),
      onError: Color.fromRGBO(255, 255, 255, 1.0),
      brightness: Brightness.dark,
      onBackground: Color(0x000000FF),
      onSurface: Color(0x000000FF),
    ),
    textTheme: screenHeight < 1000 ? textThemeSmall : textThemeDefault,
    fontFamily: 'Poppins');

const TextTheme textThemeDefault = TextTheme(
  headline1:
      TextStyle( fontWeight: FontWeight.w600, fontSize: 26),
  headline2:
      TextStyle( fontWeight: FontWeight.w600, fontSize: 22),
  headline3:
      TextStyle( fontWeight: FontWeight.w600, fontSize: 20),
  headline4:
      TextStyle( fontWeight: FontWeight.w600, fontSize: 16),
  headline5:
      TextStyle( fontWeight: FontWeight.w600, fontSize: 14),
  headline6:
      TextStyle( fontWeight: FontWeight.w600, fontSize: 12),
  bodyText1: TextStyle(
       fontWeight: FontWeight.w400, fontSize: 14, height: 1.5),
  bodyText2: TextStyle(
       fontWeight: FontWeight.w400, fontSize: 14, height: 1.5),
  subtitle1:
      TextStyle( fontWeight: FontWeight.w400, fontSize: 12),
  subtitle2:
      TextStyle( fontWeight: FontWeight.w400, fontSize: 12),
);

const TextTheme textThemeDefaultLight = TextTheme(
  headline1:
      TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 26),
  headline2:
      TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 22),
  headline3:
      TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 20),
  headline4:
      TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 16),
  headline5:
      TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 14),
  headline6:
      TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 12),
  bodyText1: TextStyle(
       color: textColor, fontWeight: FontWeight.w400, fontSize: 14, height: 1.5),
  bodyText2: TextStyle(
       color: textColor, fontWeight: FontWeight.w400, fontSize: 14, height: 1.5),
  subtitle1:
      TextStyle(color: textColor, fontWeight: FontWeight.w400, fontSize: 12),
  subtitle2:
      TextStyle(color: textColor, fontWeight: FontWeight.w400, fontSize: 12),
);

const TextTheme textThemeSmall = TextTheme(
  headline1:
      TextStyle( fontWeight: FontWeight.w600, fontSize: 22),
  headline2:
      TextStyle( fontWeight: FontWeight.w600, fontSize: 20),
  headline3:
      TextStyle( fontWeight: FontWeight.w600, fontSize: 18),
  headline4:
      TextStyle( fontWeight: FontWeight.w600, fontSize: 16),
  headline5:
      TextStyle( fontWeight: FontWeight.w600, fontSize: 14),
  headline6:
      TextStyle( fontWeight: FontWeight.w600, fontSize: 10),
  bodyText1: TextStyle(
       fontWeight: FontWeight.w400, fontSize: 12, height: 1.5),
  bodyText2: TextStyle(
       fontWeight: FontWeight.w400, fontSize: 12, height: 1.5),
  subtitle1:
      TextStyle( fontWeight: FontWeight.w400, fontSize: 10),
  subtitle2:
      TextStyle( fontWeight: FontWeight.w400, fontSize: 10),
);
