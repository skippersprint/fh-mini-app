import 'dart:ui';

import 'package:flutter/material.dart';

double screenWidth = window.physicalSize.width;

const textInputDecoration = InputDecoration(
  hintText: "Email",
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 20.0)),
  focusedBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: Color.fromARGB(255, 158, 247, 140), width: 2.0)),
);

const brandGreen = Color(0xFF23CE6B);
const brandBlack = Color(0xff272D2D);
const brandWhite = Color(0xffEEEEEE);
const brandGrey = Color(0xffd2d5dd);

const TextTheme textThemeDefault = TextTheme(
  headline1:
      TextStyle(color: brandBlack, fontWeight: FontWeight.w600, fontSize: 26),
  headline2:
      TextStyle(color: brandBlack, fontWeight: FontWeight.w600, fontSize: 22),
  headline3:
      TextStyle(color: brandBlack, fontWeight: FontWeight.w600, fontSize: 20),
  headline4:
      TextStyle(color: brandBlack, fontWeight: FontWeight.w600, fontSize: 16),
  headline5:
      TextStyle(color: brandBlack, fontWeight: FontWeight.w600, fontSize: 14),
  headline6:
      TextStyle(color: brandBlack, fontWeight: FontWeight.w600, fontSize: 12),
  bodyText1: TextStyle(
      color: brandBlack,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.5),
  bodyText2: TextStyle(
      color: brandBlack,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.5),
  subtitle1:
      TextStyle(color: brandBlack, fontWeight: FontWeight.w400, fontSize: 12),
  subtitle2:
      TextStyle(color: brandBlack, fontWeight: FontWeight.w400, fontSize: 12),
);

const TextTheme textThemeSmall = TextTheme(
  headline1:
      TextStyle(color: brandGreen, fontWeight: FontWeight.w600, fontSize: 22),
  headline2:
      TextStyle(color: brandBlack, fontWeight: FontWeight.w600, fontSize: 20),
  headline3:
      TextStyle(color: brandBlack, fontWeight: FontWeight.w600, fontSize: 18),
  headline4:
      TextStyle(color: brandBlack, fontWeight: FontWeight.w600, fontSize: 16),
  headline5:
      TextStyle(color: brandBlack, fontWeight: FontWeight.w600, fontSize: 14),
  headline6:
      TextStyle(color: brandBlack, fontWeight: FontWeight.w600, fontSize: 10),
  bodyText1: TextStyle(
      color: brandBlack,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 1.5),
  bodyText2: TextStyle(
      color: brandBlack,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 1.5),
  subtitle1:
      TextStyle(color: brandBlack, fontWeight: FontWeight.w400, fontSize: 10),
  subtitle2:
      TextStyle(color: brandBlack, fontWeight: FontWeight.w400, fontSize: 10),
);
