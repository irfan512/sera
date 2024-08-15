import 'package:flutter/material.dart';
import 'package:sera/util/app_strings.dart';

class VendorStepIndicator extends StatelessWidget {
  final int currentIndex;
  final Color defaultColor;
  final Color activeColor;

  const VendorStepIndicator({
    Key? key,
    required this.currentIndex,
    required this.defaultColor,
    required this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildStep(
          theme,
          0,
          currentIndex,
          AppStrings.PERSONAL_INFO,
          defaultColor,
          activeColor,
        ),
        const SizedBox(width: 10),
        _buildStep(
          theme,
          1,
          currentIndex,
          AppStrings.BRAND_IDENTIFY,
          defaultColor,
          activeColor,
        ),
        const SizedBox(width: 10),
        _buildStep(
          theme,
          2,
          currentIndex,
          AppStrings.ADD_STYLE,
          defaultColor,
          activeColor,
        ),
      ],
    );
  }

  Widget _buildStep(
    ThemeData theme,
    int stepIndex,
    int currentIndex,
    String text,
    Color defaultColor,
    Color activeColor,
  ) {
    final isActive = stepIndex == currentIndex;

    return Expanded(
      child: Column(
        children: [
          Container(
            color: isActive ? activeColor : defaultColor,
            height: 2,
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: theme.textTheme.titleLarge!.copyWith(
              color: isActive ? activeColor : theme.colorScheme.primaryContainer,
              fontWeight: isActive?FontWeight.w500:FontWeight.w400,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}