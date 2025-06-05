import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/text_constants.dart';
import 'package:dating_app/screens/app_settings/widget/app_setting_context.dart';
import 'package:flutter/material.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextConstants.appSettings),
        backgroundColor: ColorConstants.primary,
        foregroundColor: Colors.white,
      ),
      body: AppSettingsContext(),
    );
  }
}
