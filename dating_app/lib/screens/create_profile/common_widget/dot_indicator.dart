import 'package:dating_app/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class DotIndicatorWidget extends StatelessWidget {
  final int currentIndex;
  final bool shouldSkip;

  const DotIndicatorWidget({
    super.key,
    required this.currentIndex,
    required this.shouldSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ...List.generate(6, (index) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == currentIndex
                  ? ColorConstants.primary
                  : Colors.grey.shade300,
            ),
          );
        }),
        const Spacer(),
        if (shouldSkip)
          TextButton(
            onPressed: () {
              // Implement your skip logic here
            },
            child: const Text(
              "Skip >>",
              style: TextStyle(color: ColorConstants.primary),
            ),
          ),
      ],
    );
  }
}
