import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/text_constants.dart';
import 'package:dating_app/screens/common_widget/submit_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _createTermsAndCondition(context),
              const SizedBox(
                height: 10,
              ),
              const SubmitButton(
                title: TextConstants.createAccount,
              ),
              const SizedBox(
                height: 10,
              ),
              const SubmitButton(
                title: TextConstants.signIn,
                buttonColor: ColorConstants.secondary,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _createTermsAndCondition(BuildContext context) {
    final textColor = ColorConstants.textColor;
    final clickableText = ColorConstants.grey;
    return Text.rich(
      TextSpan(
        text: "By tapping 'Sign in' / 'Create account', you agree to our ",
        style: TextStyle(color: textColor, fontSize: 13),
        children: [
          TextSpan(
            text: "Terms of Service",
            style: TextStyle(
              color: clickableText,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // TODO: Handle Terms of Service tap
              },
          ),
          const TextSpan(
            text: ". Learn how we process your data in our ",
          ),
          TextSpan(
            text: "Privacy Policy",
            style: TextStyle(
              color: clickableText,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // TODO: Handle Privacy Policy tap
              },
          ),
          const TextSpan(text: " and "),
          TextSpan(
            text: "Cookies Policy",
            style: TextStyle(
              color: clickableText,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // TODO: Handle Cookies Policy tap
              },
          ),
          const TextSpan(text: "."),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
