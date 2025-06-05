import 'package:flutter/material.dart';
import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/screens/onboarding/widget/onboarding_content.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12.0),
          child: OnboardingContent(),
        ),
      ),
    );
  }
}
