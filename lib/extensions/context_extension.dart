import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';


extension BuildContextExtension on BuildContext {
  bool get isHaveBottomNotch => window.viewPadding.bottom > 0 && Platform.isIOS;

  Size get mediaSize => MediaQuery.of(this).size;

  ThemeData get theme => Theme.of(this);

  bool get isDarkTheme => theme.brightness == Brightness.dark;


  double get statusBarHeight => MediaQuery.of(this).viewPadding.top;

  double get bottomNotchHeight => MediaQuery.of(this).viewPadding.bottom;

  void unfocus() => FocusScope.of(this).unfocus();

  bool get isKeyboardNotOpen => MediaQuery.of(this).viewInsets.bottom == 0;
}
