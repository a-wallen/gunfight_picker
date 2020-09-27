import 'package:flutter/material.dart';

const Color smoky_black = Color.fromRGBO(15, 16, 11, 1);
const Color jacko_bean = Color.fromRGBO(64, 70, 34, 1);
const Color dark_vanilla = Color.fromRGBO(194, 207, 161, 1);
const Color lotion = Color.fromRGBO(252, 252, 252, 1);
const Color davys_grey = Color.fromRGBO(82, 88, 86, 1);
const Color middle_green = Color.fromRGBO(82, 138, 99, 1);

const Gradient compassGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [davys_grey, lotion],
);

ThemeData mw_theme = ThemeData(
  appBarTheme: AppBarTheme(
    centerTitle: true,
    color: lotion,
  ),
  fontFamily: 'MW',
);
