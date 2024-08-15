import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeviceTypeScaffold extends StatelessWidget {
  final Widget widget;

  const DeviceTypeScaffold({required this.widget});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? CupertinoPageScaffold(child: widget) : Scaffold(body: widget);
  }
}
