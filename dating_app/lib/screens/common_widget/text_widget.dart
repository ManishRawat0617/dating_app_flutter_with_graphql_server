import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final Color? textColor;
  final double? textSize;
  final FontWeight? boldness;
  final TextAlign? textAlign;
  const TextWidget(
      {super.key,
      required this.title,
      this.textColor,
      this.textSize,
      this.boldness,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: TextStyle(
          color: textColor, fontSize: textSize ?? 18, fontWeight: boldness),
    );
  }
}
