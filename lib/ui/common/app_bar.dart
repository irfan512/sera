import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? elevation;
  final Color? backgroundColor;
  final Widget? title;
  final List<Widget>? actions;
  final VoidCallback? onActionPressed;
  final Widget? leading;
  final VoidCallback? onLeadingPressed;
  final bool iscenterTitle;
  final bool isbottom;

  CustomAppBar({
    this.elevation,
    this.backgroundColor,
    this.title,
    this.actions,
    this.onActionPressed,
    this.leading,
    this.onLeadingPressed,
    this.iscenterTitle = false,
    this.isbottom = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation ?? 4.0,
      centerTitle: iscenterTitle,
      scrolledUnderElevation: 0.0,
      bottom: isbottom == true
          ? PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: Container(
                color: Colors.black,
                height: 0.2,
              ))
          : null,
      backgroundColor: backgroundColor ?? Colors.transparent,
      automaticallyImplyLeading: false,
      title: title ?? const SizedBox(),
      actions: actions?.map((action) {
        return GestureDetector(
          onTap: onActionPressed,
          child: action,
        );
      }).toList(),
      leading: leading != null
          ? GestureDetector(
              onTap: onLeadingPressed,
              child: leading,
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
