import 'package:flutter/material.dart';
import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';

class SubscriptionSuccessPage extends StatelessWidget {
  const SubscriptionSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Checkmark Icon
                Container(
                  width: size.width * 0.3,
                  height: size.width * 0.3,
                  decoration: BoxDecoration(
                    color: ColorConstants.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.verified_rounded,
                    color: ColorConstants.primary,
                    size: size.width * 0.18,
                  ),
                ),
                SizedBox(height: size.height * 0.04),

                /// Heading
                TextWidget(
                  title: "Subscription Successful!",
                  textSize: 24,
                  boldness: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height * 0.02),

                /// Subheading
                TextWidget(
                  title:
                      "You’re now a premium member. Enjoy unlimited matches and priority visibility!",
                  textSize: 16,
                  boldness: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height * 0.06),

                /// Continue to App button
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.25,
                      vertical: 14,
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
