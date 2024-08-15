import 'package:flutter/material.dart';
import 'package:sera/extensions/context_extension.dart';
import '../../util/app_strings.dart';

class NetworkErrorTryAgain extends StatelessWidget {
  final EdgeInsetsDirectional margin;
  final VoidCallback onClick;

  const NetworkErrorTryAgain({super.key, required this.margin, required this.onClick});
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;
    return Container(
        width: context.mediaSize.width,
        margin: margin,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppStrings.LIMITED_NETWORK_CONNECTION, style: textTheme.bodyLarge, textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text(AppStrings.LIMITED_NETWORK_CONNECTION_CONTENT, style: textTheme.bodySmall, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              MaterialButton(onPressed: () => onClick.call(), child: Text(AppStrings.TRY_AGAIN, style: textTheme.labelLarge))
            ]));
  }
}
