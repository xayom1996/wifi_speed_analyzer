import 'package:flutter/material.dart';

import 'color_theme.dart';

enum AppTheme {
  RedLight,
  RedDark,
}

final appThemeData = {
  AppTheme.RedLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryRed,
    scaffoldBackgroundColor: white1,
    primaryColorLight: white2,
    primaryColorDark: secondaryDBlue,
  ),
  AppTheme.RedDark: ThemeData(
    fontFamily: 'OpenSans',
    brightness: Brightness.dark,
    primaryColor: primaryRed,
    scaffoldBackgroundColor: backgroundColor,
    primaryColorDark: white2,
    primaryColorLight: secondaryDBlue,
  ),
};