import 'package:flutter/material.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/util/base_constants.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function? onClick;
  final double borderRadius;
  final Color? color;
  final Color? textColor;
  final double fontSize;
  final bool isEnabled;
  final String fontFamily;
  final double? elevation;
  final bool isborder;
  final Color? borderColor;

  const AppButton({
    super.key,
    required this.text,
    required this.onClick,
    this.borderRadius = 15,
    this.color,
    this.fontFamily = BaseConstant.poppinsMedium,
    this.textColor,
    this.fontSize = 15,
    this.elevation,
    this.isEnabled = true,
    this.isborder = false,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return RawMaterialButton(
        elevation: elevation ?? 2.0,
        constraints: const BoxConstraints(minHeight: 44, maxHeight: 44),
        onPressed: isEnabled ? () => onClick?.call() : null,
        fillColor: isEnabled ? color : colorScheme.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: isborder == true
                ? BorderSide(
                    color: borderColor ?? theme.colorScheme.primaryContainer)
                : BorderSide.none),
        child: Text(text,
            style:
                textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color:textColor??colorScheme.onPrimary)));
  }
}

class IconAppButton extends StatelessWidget {
  final Widget? prefixIcon;
  final bool isBorder;
  final String text;
  final Function? onClick;
  final double borderRadius;
  final Color? color;
  final Color? textColor;
  final double fontSize;
  final bool isEnabled;
  final String fontFamily;

  const IconAppButton(
      {super.key,
      required this.text,
      required this.onClick,
      this.borderRadius = 15,
      this.isBorder = false,
      this.color,
      this.fontFamily = BaseConstant.poppinsMedium,
      this.textColor,
      this.fontSize = 10,
      this.isEnabled = true,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          // border: Border.all(color: colorScheme.secondaryContainer.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(borderRadius)),
      child: RawMaterialButton(
          constraints: const BoxConstraints(minHeight: 44, maxHeight: 44),
          onPressed: isEnabled ? () => onClick?.call() : null,
          fillColor: isEnabled ? color : theme.primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                prefixIcon != null ? prefixIcon! : const SizedBox(),
                SizedBox(width: prefixIcon != null ? 5 : 0),
                Text(text,
                    style: textTheme.titleMedium!
                        .copyWith(color: colorScheme.onPrimary))
              ])),
    );
  }
}

class AppIconButton extends StatelessWidget {
  final Widget? suffix;
  final bool isBorder;
  final String text;
  final Function? onClick;
  final double borderRadius;
  final Color? color;
  final Color borderColor;
  final Color? textColor;
  final double fontSize;
  final bool isEnabled;
  final String fontFamily;

  const AppIconButton(
      {super.key,
      required this.text,
      required this.onClick,
      this.borderRadius = 4,
      this.isBorder = false,
      this.color,
      this.fontFamily = BaseConstant.poppinsMedium,
      this.textColor,
      this.fontSize = 15,
      this.borderColor = Colors.transparent,
      this.isEnabled = true,
      this.suffix});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: RawMaterialButton(
          constraints: const BoxConstraints(minHeight: 44, maxHeight: 44),
          onPressed: isEnabled ? () => onClick?.call() : null,
          fillColor: isEnabled ? color : Colors.white54,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(color: borderColor)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(text,
                        style: TextStyle(
                            color: textColor,
                            fontFamily: fontFamily,
                            fontSize: fontSize)),
                  ),
                  SizedBox(width: suffix != null ? 5 : 0),
                  suffix != null ? suffix! : const SizedBox(),
                ]),
          )),
    );
  }
}
