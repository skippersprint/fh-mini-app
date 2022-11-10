import 'dart:ui';

import 'package:fh_mini_app/config/palette.dart';
import 'package:fh_mini_app/config/theme.dart';
import 'package:flutter/material.dart';

double screenHeight = window.physicalSize.height;

var accentColor = Color.fromARGB(235, 15, 255, 215);

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Color.fromARGB(255, 61, 61, 61), // has no use
      primarySwatch: Palette.lightPalette,
      scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      fontFamily: 'Poppins',

      textTheme: screenHeight < 1000 ? textThemeSmall : textThemeDefaultLight,
      colorScheme: ColorScheme(
        primary: Color.fromARGB(255, 61, 61, 61),
        secondary: Color.fromARGB(255, 61, 61, 61),
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
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Color.fromARGB(255, 61, 61, 61), //not used anywhere
      //backgroundcolor

      scaffoldBackgroundColor: Color.fromARGB(255, 40, 40, 40),
      backgroundColor: Colors.amber,
      //primaryColorDark: ,
      primarySwatch: Palette.kToDark,
      fontFamily: 'Poppins',
      textTheme: screenHeight < 1000 ? textThemeSmall : textThemeDefault,
      //brightness: Brightness.dark,
      focusColor: Colors.red,

      colorScheme: ColorScheme(
        primary: Color.fromARGB(255, 61, 61, 61),
        secondary: accentColor,
        error: Color.fromARGB(183, 255, 43, 28),
        surface: Color.fromRGBO(255, 255, 255, 1.0),
        onPrimary: Color.fromRGBO(255, 255, 255, 1.0),
        background: Color.fromRGBO(198, 218, 231, 1.0),
        onSecondary: Color.fromRGBO(255, 255, 255, 1.0),
        onError: Color.fromRGBO(255, 255, 255, 1.0),
        brightness: Brightness.dark,
        onBackground: Color(0x000000FF),
        onSurface: Color(0x000000FF),
      ),
    );
  }
}