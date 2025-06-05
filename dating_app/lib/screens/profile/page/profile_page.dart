import 'package:flutter/material.dart';
import 'package:dating_app/screens/profile/widget/profile_context.dart';
import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/text_constants.dart';

import 'package:dating_app/screens/common_widget/text_widget.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const  TextWidget(
                title: "Profile",
                textSize: 26,
                textAlign: TextAlign.right,
                textColor: ColorConstants.white,
              ),
        centerTitle: true,
        backgroundColor:ColorConstants.primary,
        foregroundColor: Colors.black,
      ),
      body: ProfileContext()
    );
  }
}