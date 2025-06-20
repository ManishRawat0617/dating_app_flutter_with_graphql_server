import 'dart:ui';

import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildLifestyleRow(String title, String value, String icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        SvgPicture.asset(
          icon,
          height: 24,
          width: 24,
          color: ColorConstants.textColor1, // Optional
        ),
        const SizedBox(width: 15),
        Expanded(
            child: TextWidget(
          title: title,
          textSize: 15,
          boldness: FontWeight.bold,
          textColor: ColorConstants.textColor3,
        )),
        TextWidget(
          title: value,
          textSize: 15,
          textColor: Colors.blueGrey,
          boldness: FontWeight.w500,
        )
      ],
    ),
  );
}
