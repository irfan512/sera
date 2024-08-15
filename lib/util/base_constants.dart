import 'package:flutter/material.dart';

abstract class BaseConstant {
  /// app font families
  static const String poppinsBold = 'Poppins_Bold';
  static const String poppinsMedium = 'Poppins_Medium';
  static const String poppinsRegular = 'Poppins_Regular';
  static const String poppinsSemibold = 'Poppins_SemiBold';
  static const String poppinsLight = 'Poppins_Light';

  abstract Color colorSurface;
  abstract Color colorOnSurface;
  abstract Color colorBackground;
  abstract Color colorOnBackground;
  abstract final Color colorOnSurfaceEmphasisHigh;
  abstract final Color colorOnSurfaceEmphasisMedium;
  abstract final Color colorOnSurfaceEmphasisDisabled;
  abstract final ThemeData themeData;

  Color colorPrimary = const Color(0xFFC0C6B8);
  Color colorOnPrimary = Colors.white;
  Color colorPrimaryContainer = const Color(0xFF999999);
  Color colorOnPrimaryContainer = const Color(0xFFB2BBA6);
  Color colorSecondary = const Color(0xff000000);
  Color colorOnSecondary = Color(0xffF8F8F7);
  Color colorSecondaryContainer = const Color(0xff979897);
  Color colorOnSecondaryContainer = const Color(0xff888F7F);

  /// textfield bg color
  Color colorTertiaryContainer = const Color(0xffF8F8F7);
  Color colorOnTertiaryContainer = const Color(0xff827A7A);
  Color colorError = const Color(0xffB30A0A);
  Color colorOnError = Colors.white;
  Color textfieldColor = const Color(0xfff2f2f2);

  static const Color signupSliderColor = Color(0xffB2BBA6);
  static const Color addressSelectionColor = Color(0xffC1C1C1);
  static const Color selectedUserdataColor = Color(0xff9D9D9D);
  static const Color bottombarUnSelectedColor = Color(0xffB3B3B3);
  static const Color brandIdentityColor = Color(0xffF3F4F3);
  static const Color homeStoryTileColor = Color(0xffD9D9D9);
  static const Color profileScreenBg = Color(0xffE7E9E5);
  static const Color notificationSubtitleColor = Color(0xff9D9489);
  static const Color salesChartColor = Color(0xffF8F8F7);
  static const Color salesChartGoalBarColor = Color(0xffB2BBA6);

// .....................Order Status colors ........................//

  static const Color orderStatus2Color = Color(0xffFBD48D);
  static const Color orderStatus3Color = Color(0xffB9D7ED);
  static const Color orderStatus4Color = Color(0xffCADFB3);
  static const Color orderStatus5Color = Color(0xffE9E9F2);
  static const Color orderStatus1Color = Color(0xffC0C6B8);

  static const Color darkTextField = Color(0xff000000);
}
