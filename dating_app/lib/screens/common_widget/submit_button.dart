import 'package:dating_app/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';

class SubmitButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? buttonColor;
  final double? buttonColorCapacity;
  final Color? textColor;
  final double? borderRadius;
  final String title;
  final VoidCallback? ontap;
  final bool? isEnabled;

  const SubmitButton({
    super.key,
    this.height,
    this.width,
    this.buttonColor,
    this.textColor,
    required this.title,
    this.borderRadius,
    this.ontap,
    this.buttonColorCapacity, this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final Color finalButtonColor = (buttonColor != null
        ? buttonColor!.withOpacity(buttonColorCapacity ?? 1)
        : ColorConstants.primary);

    return InkWell(
      onTap: ontap,
      child: Container(
        height: height ?? 50,
        width: width ?? screenWidth,
        decoration: BoxDecoration(
          color: finalButtonColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
        ),
        alignment: Alignment.center,
        child: TextWidget(
          title: title,
          textColor: textColor ?? Colors.white,
          textSize: 16,
          boldness: FontWeight.w600,
        ),
      ),
    );
  }
}
