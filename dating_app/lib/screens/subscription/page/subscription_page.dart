import 'package:dating_app/core/constants/path_constants.dart';
import 'package:dating_app/screens/subscription/page/continu.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/core/constants/color_constants.dart'; // your color constants file
import 'package:dating_app/screens/common_widget/text_widget.dart'; // your custom TextWidget

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  String? _selectedPlan; // To store which plan user selected

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorConstants.primary,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Upgrade to Premium',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorConstants.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorConstants.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.06,
            vertical: size.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                PathConstants.subscription,
                height: size.height * 0.3,
              ),
              SizedBox(height: size.height * 0.01),
              TextWidget(
                title: "Find Your Perfect Match Faster",
                textSize: 22,
                boldness: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.02),
              TextWidget(
                title:
                    "Unlock exclusive features and boost your profile visibility!",
                textSize: 16,
                boldness: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.04),

              /// Subscription Plans
              _buildSubscriptionPlan(
                title: "1 Month",
                price: "\$9.99 / month",
                value: "1_month",
              ),
              SizedBox(height: size.height * 0.02),
              _buildSubscriptionPlan(
                title: "6 Months",
                price: "\$7.49 / month (Billed \$44.99)",
                value: "6_months",
                highlight: true,
              ),
              SizedBox(height: size.height * 0.02),
              _buildSubscriptionPlan(
                title: "12 Months",
                price: "\$5.99 / month (Billed \$71.88)",
                value: "12_months",
              ),

              SizedBox(height: size.height * 0.05),

              ElevatedButton(
                onPressed: _selectedPlan != null
                    ? () {
                        // Navigate to success page or payment flow
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const SubscriptionSuccessPage(),
                          ),
                        );
                      }
                    : null, // Disable button if no plan selected
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedPlan != null
                      ? ColorConstants.primary
                      : Colors.grey.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.3,
                    vertical: 14,
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: size.height * 0.02),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Restore Purchase",
                  style: TextStyle(
                    color: ColorConstants.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionPlan({
    required String title,
    required String price,
    required String value,
    bool highlight = false,
  }) {
    bool isSelected = _selectedPlan == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPlan = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorConstants.primary.withOpacity(0.2)
              : (highlight
                  ? ColorConstants.primary.withOpacity(0.1)
                  : Colors.white),
          border: Border.all(
            color: isSelected
                ? ColorConstants.primary
                : (highlight ? ColorConstants.primary : Colors.pinkAccent),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.favorite,
              color: isSelected
                  ? ColorConstants.primary
                  : (highlight ? ColorConstants.primary : Colors.pinkAccent),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            if (highlight && !isSelected)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: ColorConstants.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Best Value",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: ColorConstants.primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
