import 'package:flutter/material.dart';
import 'package:sera/extensions/context_extension.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final Color fillColor;
  final Color borderColor;
  final ValueChanged<bool> onChanged;

  const CustomCheckbox(
      {super.key,
      required this.value,
      required this.onChanged,
      this.fillColor = Colors.white,
      this.borderColor = Colors.grey});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;

    return GestureDetector(
        onTap: () => onChanged(!value),
        child: Row(children: [
          Container(
              width: 18,
              height: 18,
              margin: const EdgeInsets.only(left: 6.0, right: 8.0),
              decoration: BoxDecoration(
                  color: value ? colorScheme.onPrimary : fillColor,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                      color: value ? colorScheme.secondary : borderColor,
                      width: 1)),
              child: Center(
                  child: value
                      ? const Icon(
                          Icons.check,
                          size: 12,
                          color: Colors.black,
                        )
                      : const SizedBox.shrink()))
        ]));
  }
}
