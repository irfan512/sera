import 'package:flutter/material.dart';
import 'package:sera/extensions/context_extension.dart';

class AppTextField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hint;
  final bool textColor;
  final bool whiteColor;
  final double height;
  final int maxLines;
  final TextInputType textInputType;
  final bool isError;
  final double radius;
  final TextInputAction textInputAction;
  final bool isObscure;
  final bool readOnly;
  final bool enabled;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function(String)? onSubmit;
  final Function()? onSuffixClick;

  const AppTextField(
      {super.key,
      required this.hint,
      required this.textInputType,
      required this.isError,
      this.controller,
      this.onChanged,
      this.radius = 8.0,
      this.isObscure = false,
      this.suffixIcon,
      this.onSuffixClick,
      this.prefixIcon,
      this.readOnly = false,
      this.enabled = true,
      this.height = 40,
      this.maxLines = 1,
      this.textInputAction = TextInputAction.next,
      this.onSubmit,
      this.onTap,
      this.textColor = false,
      this.whiteColor = false});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(right: 2, left: 2),
        margin: const EdgeInsets.only(bottom: 8, top: 8),
        height: height,
        child: Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(radius),
            color: Colors.white,
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    right: 10, left: prefixIcon != null ? 0 : 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    border: Border.all(color: colorScheme.primaryContainer,width: 0.5),
                    color: Colors.white),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      prefixIcon != null
                          ? Container(
                              height: 55,
                              width: 50,
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: context.isDarkTheme
                                      ? colorScheme.surface
                                      : colorScheme.tertiaryContainer,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5))),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 5),
                                  child: prefixIcon!))
                          : const SizedBox(),
                      Expanded(
                          child: TextFormField(
                              onFieldSubmitted: onSubmit,
                              maxLines: maxLines,
                              readOnly: readOnly,
                              onTap: onTap,
                              enabled: enabled,
                              obscureText: isObscure,
                              controller: controller,
                              onChanged: onChanged,
                              keyboardType: textInputType,
                              textInputAction: textInputAction,
                              style: textTheme.labelLarge!.copyWith(
                                  color: textColor
                                      ? const Color(0xFF4969CE)
                                      : context.isDarkTheme
                                          ? colorScheme.onPrimary
                                          : colorScheme.onSecondaryContainer,
                                  fontSize: 14),
                              decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(top: -10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: hint,
                                  hintStyle: textTheme.labelLarge!.copyWith(
                                      color: colorScheme.primaryContainer,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14)))),
                      suffixIcon != null
                          ? GestureDetector(
                              onTap: () => onSuffixClick?.call(),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 5),
                                  child: suffixIcon!))
                          : const SizedBox()
                    ]))));
  }
}
