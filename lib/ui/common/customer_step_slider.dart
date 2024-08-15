import 'package:flutter/material.dart';
import 'package:sera/util/app_strings.dart';

class CustomerStepIndicator extends StatelessWidget {
  final int currentIndex;
  final Color defaultColor;
  final Color activeColor;

  const CustomerStepIndicator({
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
          AppStrings.ADDRESS,
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
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}