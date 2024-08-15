import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as flutter_widgets;
import 'package:sera/extensions/context_extension.dart';
import '../data/snackbar_message.dart';
import '../ui/common/flushbar.dart';
import '../util/base_constants.dart';

class SnackbarHelper {
  static SnackbarHelper? _instance;

  SnackbarHelper._internal();

  static SnackbarHelper instance() {
    _instance ??= SnackbarHelper._internal();
    return _instance!;
  }

  Flushbar? _lastFlushbar;
  flutter_widgets.BuildContext? _context;

  void injectContext(BuildContext context) {
    _context = context;
  }

  void showSnackbar({required SnackbarMessage snackbarMessage, EdgeInsets margin = const EdgeInsets.all(8)}) async {
    final context = _context;
    if (context == null) return;

    final theme = context.theme;

    final tempLastFlushbar = _lastFlushbar;
    if (tempLastFlushbar != null && tempLastFlushbar.isShowing()) {
      await tempLastFlushbar.dismiss();
    }

    _lastFlushbar = Flushbar(
        animationDuration: const Duration(milliseconds: 850),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        duration: snackbarMessage.duration,
        messageText: Text(snackbarMessage.content,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: snackbarMessage.isForError ? theme.colorScheme.error : theme.colorScheme.primary,
                fontFamily: BaseConstant.poppinsRegular,
                fontSize: 15)),
        margin: margin,
        shouldIconPulse: false,
        mainButton: null,
        leftBarIndicatorColor: snackbarMessage.isForError ? theme.colorScheme.error : theme.colorScheme.primary,
        onStatusChanged: (status) {},
        backgroundColor: theme.colorScheme.onPrimary,
        borderRadius: const BorderRadius.all(Radius.circular(10)));
    // ignore: use_build_context_synchronously
    _lastFlushbar?.show(context);
  }

  Widget? _getSnackbarIcon(bool isForError) {
    if (isForError) {
      return const Icon(CupertinoIcons.info_circle_fill, color: Colors.red, size: 24);
    }
    return null;
  }
}
