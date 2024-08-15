// import 'package:flutter/material.dart';
// import 'package:sera/extensions/context_extension.dart';
// import 'package:sera/util/base_constants.dart';

// class SearchTextField extends StatelessWidget {
//   final String hint;
//   final TextInputAction textInputAction;
//   final TextInputType textInputType;
//   final double? width;
//   final TextEditingController textEditingController;
//   final bool isObscure;
//   final TextAlign textAlign;
//   final Widget suffixIcon;
//   final bool enabled;
//   final bool readOnly;
//   final Function(String)? onChanged;
//   final Function()? onTap;

//   const SearchTextField(
//       {required this.hint,
//       required this.textInputType,
//       required this.textInputAction,
//       this.width,
//       required this.textEditingController,
//       this.textAlign = TextAlign.start,
//       this.isObscure = false,
//       this.enabled = true,
//       this.readOnly = false,
//       this.onChanged,
//       this.onTap,
//       this.suffixIcon = const SizedBox()});

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = context.theme.colorScheme;

//     return Material(
//         elevation: 2,
//         shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
//         color: Colors.white,
//         child: TextField(
//             controller: textEditingController,
//             style: TextStyle(color: colorScheme.secondary, fontFamily: BaseConstant.poppinsRegular, fontSize: 14),
//             textInputAction: textInputAction,
//             keyboardType: textInputType,
//             textAlign: textAlign,
//             obscureText: isObscure,
//             readOnly: readOnly,
//             maxLines: 1,
//             minLines: 1,
//             obscuringCharacter: '*',
//             cursorHeight: 18,
//             onChanged: onChanged,
//             onTap: onTap,
//             decoration: InputDecoration(
//                 suffixIcon: Padding(padding: const EdgeInsets.only(right: 8.0), child: suffixIcon),
//                 suffixIconColor: const Color(0xff16098D),
//                 suffixIconConstraints: const BoxConstraints(maxHeight: 20, maxWidth: 35, minHeight: 16, minWidth: 16),
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 10),
//                 border: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 enabledBorder: InputBorder.none,
//                 disabledBorder: InputBorder.none,
//                 errorBorder: InputBorder.none,
//                 hintText: hint,
//                 hintStyle: TextStyle(
//                     color: colorScheme.onSecondaryContainer,
//                     fontFamily: BaseConstant.poppinsRegular,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 14))));
//   }
// }




import 'package:flutter/material.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/util/base_constants.dart';

class SearchTextField extends StatelessWidget {
  final String hint;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final double? width;
  final TextEditingController textEditingController;
  final bool isObscure;
  final TextAlign textAlign;
  final Widget suffixIcon;
  final bool enabled;
  final bool readOnly;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted; // Add this line
  final Function()? onTap;

  const SearchTextField({
    required this.hint,
    required this.textInputType,
    required this.textInputAction,
    this.width,
    required this.textEditingController,
    this.textAlign = TextAlign.start,
    this.isObscure = false,
    this.enabled = true,
    this.readOnly = false,
    this.onChanged,
    this.onSubmitted, // Add this line
    this.onTap,
    this.suffixIcon = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    return Material(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      color: Colors.white,
      child: TextField(
        controller: textEditingController,
        style: TextStyle(
          color: colorScheme.secondary,
          fontFamily: BaseConstant.poppinsRegular,
          fontSize: 14,
        ),
        textInputAction: textInputAction,
        keyboardType: textInputType,
        textAlign: textAlign,
        obscureText: isObscure,
        readOnly: readOnly,
        maxLines: 1,
        minLines: 1,
        obscuringCharacter: '*',
        cursorHeight: 18,
        onChanged: onChanged,
        onSubmitted: onSubmitted, // Add this line
        onTap: onTap,
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: suffixIcon,
          ),
          suffixIconColor: const Color(0xff16098D),
          suffixIconConstraints: const BoxConstraints(
            maxHeight: 20,
            maxWidth: 35,
            minHeight: 16,
            minWidth: 16,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            color: colorScheme.onSecondaryContainer,
            fontFamily: BaseConstant.poppinsRegular,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
