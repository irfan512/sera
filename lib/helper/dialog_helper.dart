import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as flutter_widgets;
import 'package:sera/data/material_dailog_content.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/common/app_button.dart';
import 'package:sera/util/base_constants.dart';

class DialogHelper {
  static DialogHelper? _instance;

  DialogHelper._();

  static DialogHelper instance() {
    _instance ??= DialogHelper._();
    return _instance!;
  }

  flutter_widgets.BuildContext? _context;
  bool get isProgressShowing => _context != null;
  void injectContext(BuildContext context) => _context = context;



  void dismissProgress({BuildContext? context}) {
    final tempContext = context ?? _context;
    if (tempContext == null) return;
    Navigator.pop(tempContext);
    _context = null;
  }



  void showProgressDialog(String progressContent) {
    final context = _context;
    if (context == null) return;
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    Platform.isIOS
        ? showCupertinoDialog(
            barrierDismissible: true,
            context: context,
            builder: (dialogContext) {
              return WillPopScope(
                  onWillPop: () async => false,
                  child: CupertinoAlertDialog(
                      title: Text(progressContent,
                          style: textTheme.bodySmall!.copyWith(
                              color: colorScheme.secondaryContainer,
                              fontSize: 13)),
                      content: const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: CupertinoActivityIndicator())));
            })
        : showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => WillPopScope(
                child: Dialog(
                    insetPadding: const EdgeInsets.symmetric(horizontal: 25),
                    backgroundColor: colorScheme.surface,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(strokeWidth: 2),
                              const SizedBox(width: 15),
                              Text(progressContent,
                                  style: textTheme.bodySmall!.copyWith(
                                      color: colorScheme.secondaryContainer,
                                      fontSize: 13))
                            ]))),
                onWillPop: () async => false));
  }

  void showTitleContentDialog(
      MaterialDialogContent dialogContent, VoidCallback positiveClosure,
      {VoidCallback? negativeClosure}) {
    final context = _context;
    if (context == null) return;

    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 25),
              contentPadding: const EdgeInsets.only(bottom: 0),
              backgroundColor: colorScheme.onBackground,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              content: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(16)),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(dialogContent.title,
                                textAlign: TextAlign.center,
                                style: textTheme.titleLarge!.copyWith(
                                    color: colorScheme.onSecondaryContainer,
                                    fontFamily: BaseConstant.poppinsMedium,
                                    fontSize: 26))),
                        const SizedBox(height: 20),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(dialogContent.content,
                                textAlign: TextAlign.center,
                                style: textTheme.bodySmall!.copyWith(
                                    color: colorScheme.secondaryContainer,
                                    fontSize: 14))),
                        const SizedBox(height: 20),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: SizedBox(
                                height: 40,
                                width: double.infinity,
                                child: AppButton(
                                  borderRadius: 8,
                                  
                                    onClick: () {
                                      Navigator.pop(context);
                                      positiveClosure.call();
                                    },
                                    text: dialogContent.positiveText,
                                    fontSize: 16,
                                    color: colorScheme.onPrimaryContainer))),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              negativeClosure?.call();
                            },
                            child: Text(dialogContent.negativeText,
                                style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 16))),
                        const SizedBox(height: 25)
                      ])));
        });
  }













}
