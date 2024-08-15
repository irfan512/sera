import 'package:flutter/material.dart';
import 'package:sera/extensions/context_extension.dart';
import '../../util/base_constants.dart';

class WelcomeHeaderWidget extends StatelessWidget {
  const WelcomeHeaderWidget(
      {super.key, required this.description, required this.title});

  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    final size = context.mediaSize;
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          height: 100,
          width: size.width,
          alignment: Alignment.topLeft,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/3x/screen_top_icon.png'),
                // Padding(
                //   padding: const EdgeInsets.only(top: 20.0),
                //   child: Image.asset('assets/3x/logo.png', height: 80, width: 80),
                // ),
                Image.asset('assets/3x/screen_top_icon.png',
                    color: Colors.transparent),
                // SizedBox(width: size.width / 4),
              ])),
      Text(title,
          style: textTheme.titleLarge!.copyWith(
              color: colorScheme.onSecondaryContainer,
              fontFamily: BaseConstant.poppinsMedium,
              fontSize: 24)),
      const SizedBox(height: 5),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0),
          child: Text(description,
              textAlign: TextAlign.center,
              style: textTheme.bodySmall!.copyWith(
                  color: colorScheme.secondaryContainer, fontSize: 14))),
      Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 15),
          child: Divider(
              color: colorScheme.secondaryContainer.withOpacity(0.4),
              thickness: 1))
    ]);
  }
}
