import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'base_constants.dart';

class LightThemeConstant extends BaseConstant {
  @override
  Color colorSurface = const Color(0xfff9f8f8);

  @override
  Color colorOnSurface = const Color(0xff1C1C1C);

  @override
  Color colorBackground = const Color(0xffffffff);

  @override
  Color colorOnBackground = const Color(0xff1C1C1C);

  @override
  Color get colorOnSurfaceEmphasisDisabled => colorOnSurface.withAlpha(51);

  @override
  Color get colorOnSurfaceEmphasisHigh => colorOnSurface.withAlpha(230);

  @override
  Color get colorOnSurfaceEmphasisMedium => colorOnSurface.withAlpha(153);

  @override
  ThemeData get themeData => ThemeData(
    scaffoldBackgroundColor: colorBackground,
      brightness: Brightness.light,
      textTheme: TextTheme(
          displaySmall: TextStyle(
              fontFamily: BaseConstant.poppinsSemibold, color: colorOnSurfaceEmphasisHigh, letterSpacing: -0.00833333333),
          headlineMedium:
              TextStyle(fontFamily: BaseConstant.poppinsBold, color: colorOnSurfaceEmphasisHigh, letterSpacing: 0),
          headlineSmall: TextStyle(
              fontFamily: BaseConstant.poppinsBold, color: colorOnSurfaceEmphasisHigh, letterSpacing: 0.00735294118),
          titleLarge:
              TextStyle(
                fontFamily: BaseConstant.poppinsSemibold, color: colorOnSurfaceEmphasisHigh, letterSpacing: 0),
          titleMedium:
              TextStyle(fontFamily: BaseConstant.poppinsMedium, color: colorOnSurfaceEmphasisHigh, letterSpacing: 0.0125),
          titleSmall: TextStyle(
              fontFamily: BaseConstant.poppinsRegular, color: colorOnSurfaceEmphasisHigh, letterSpacing: 0.009375),
          bodyLarge: TextStyle(
              fontFamily: BaseConstant.poppinsBold, color: colorOnSurfaceEmphasisHigh, letterSpacing: 0.00714285714),
          bodyMedium:
              TextStyle(fontFamily: BaseConstant.poppinsBold, color: colorOnSurfaceEmphasisHigh, letterSpacing: 0.03125),
          labelLarge: TextStyle(
              fontFamily: BaseConstant.poppinsRegular,
              color: colorOnSurfaceEmphasisHigh,
              fontSize: 12,
              letterSpacing: 0.0333333333),
          bodySmall: TextStyle(
              fontFamily: BaseConstant.poppinsRegular, color: colorOnSurfaceEmphasisHigh, letterSpacing: 0.0178571429)),

      // appBarTheme: AppBarTheme(
      //     backgroundColor: colorPrimary,
      //     toolbarHeight: 0,
      //     systemOverlayStyle: SystemUiOverlayStyle(
      //         systemNavigationBarColor: colorSurface,
      //         systemNavigationBarDividerColor: colorSurface,
      //         systemNavigationBarIconBrightness: Brightness.dark,
      //         statusBarBrightness: Brightness.light,
      //         statusBarIconBrightness: Brightness.dark,
      //         statusBarColor: colorSurface)),


      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: colorOnPrimary,
          statusBarColor:colorOnPrimary,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light
        )
      ),

      cupertinoOverrideTheme: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: colorPrimary,
          scaffoldBackgroundColor: colorBackground,
          primaryContrastingColor: colorOnPrimary),
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: colorPrimary,
          onPrimary: colorOnPrimary,
          primaryContainer: colorPrimaryContainer,
          onPrimaryContainer: colorOnPrimaryContainer,
          secondary: colorSecondary,
          onSecondary: colorOnSecondary,
          secondaryContainer: colorSecondaryContainer,
          onSecondaryContainer: colorOnSecondaryContainer,
          tertiary: textfieldColor,
          error: colorError,
          onError: colorOnError,
          background: colorBackground,
          onBackground: colorOnBackground,
          tertiaryContainer: colorTertiaryContainer,
          onTertiaryContainer: colorOnTertiaryContainer,
          surface: colorSurface,
          onSurface: colorOnSurface),
      useMaterial3: true);
}
