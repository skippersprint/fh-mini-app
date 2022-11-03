import 'dart:ui';

import 'package:fh_mini_app/config/palette.dart';
import 'package:fh_mini_app/config/theme.dart';
import 'package:flutter/material.dart';

double screenHeight = window.physicalSize.height;

var accentColor = Color.fromARGB(235, 187, 255, 0);

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Color.fromARGB(255, 61, 61, 61), // has no use
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 61, 61, 61)),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),

  

      //custom made pallete
      primarySwatch: Palette.lightPalette,
      scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      fontFamily: 'Poppins',
      toggleButtonsTheme: ToggleButtonsThemeData(
        splashColor: Color.fromARGB(0, 0, 0, 0),
        fillColor: Color.fromARGB(0, 0, 0, 0),

        borderColor: Color.fromARGB(255, 255, 255, 255),
                     selectedBorderColor: Color.fromARGB(255, 255, 255, 255),

        //unselected icons color
        color: Color.fromARGB(255, 155, 155, 155),
        selectedColor: Color.fromARGB(255, 61, 61, 61),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          foregroundColor: Color.fromARGB(255, 58, 58, 58)),

      sliderTheme: SliderThemeData(
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
       
        showValueIndicator: ShowValueIndicator.always,
      ),

      //bottomAppBarColor: Color.fromARGB(255, 218, 218, 218),
      textTheme: screenHeight < 1000 ? textThemeSmall : textThemeDefaultLight,
      colorScheme: ColorScheme(
        primary: Color.fromARGB(255, 71, 71, 71),
        secondary: Color.fromARGB(255, 155, 155, 155),
        error: Color.fromARGB(183, 247, 30, 15),
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
      primaryColor:
          Color.fromARGB(255, 61, 61, 61), //used in scroll wheel button
      bottomAppBarColor: Color.fromARGB(255, 31, 31, 31),
      //custom made pallete
      primarySwatch: Palette.kToDark,
      appBarTheme: AppBarTheme(
        backgroundColor: Color.fromARGB(255, 40, 40, 40),
        iconTheme: IconThemeData(color: accentColor),
      ),

      toggleButtonsTheme: ToggleButtonsThemeData(
        splashColor: Color.fromARGB(0, 0, 0, 0),
        fillColor: Color.fromARGB(0, 0, 0, 0),

        borderColor: Color.fromARGB(255, 40, 40, 40),
        selectedBorderColor: Color.fromARGB(255, 40, 40, 40),

        //unselected icons color
        color: Color.fromARGB(255, 91, 91, 91),
        selectedColor: accentColor,
      ),


      
      

      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 65, 65, 65),
          foregroundColor: accentColor),

      sliderTheme: SliderThemeData(
          valueIndicatorShape: PaddleSliderValueIndicatorShape(),
          valueIndicatorColor: accentColor,
          activeTrackColor: accentColor,
          showValueIndicator: ShowValueIndicator.always),

      //backgroundcolor
      scaffoldBackgroundColor: Color.fromARGB(255, 40, 40, 40),
      backgroundColor: Colors.amber,
      //primaryColorDark: ,

      fontFamily: 'Poppins',
      textTheme: screenHeight < 1000 ? textThemeSmall : textThemeDefault,
      //brightness: Brightness.dark,
      focusColor: Colors.red,

      colorScheme: ColorScheme(
        primary: Color.fromARGB(255, 31, 31, 31),
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
