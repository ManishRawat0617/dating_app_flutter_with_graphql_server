import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/path_constants.dart';
import 'package:dating_app/screens/common_widget/loading_widget.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:dating_app/screens/subscription/bloc/subscription_page_bloc.dart';
import 'package:dating_app/screens/subscription/page/continu3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionPageContent extends StatelessWidget {
  SubscriptionPageContent({super.key});
  String? _selectedPlan; // To store which plan user selected
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        _createMainBody(context, size),
        BlocBuilder<SubscriptionPageBloc, SubscriptionPageState>(
          buildWhen: (_, curr) => curr is LoadingState,
          builder: (_, state) {
            return state is LoadingState ? LoadingWidget() : const SizedBox();
          },
        ),
      ],
    );
  }

  Widget _createMainBody(BuildContext context, Size size) {
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
                context,
                "1 Month",
                "\$9.99 / month",
                "1_month",
              ),
              SizedBox(height: size.height * 0.02),
              _buildSubscriptionPlan(
                context,
                "6 Months",
                "\$7.49 / month (Billed \$44.99)",
                "6_months",
                highlight: true,
              ),
              SizedBox(height: size.height * 0.02),
              _buildSubscriptionPlan(
                context,
                "12 Months",
                "\$5.99 / month (Billed \$71.88)",
                "12_months",
              ),

              SizedBox(height: size.height * 0.05),

              BlocBuilder<SubscriptionPageBloc, SubscriptionPageState>(
                builder: (_, state) => ElevatedButton(
                  onPressed: state.selectedPlan != null
                      ? () => context
                          .read<SubscriptionPageBloc>()
                          .add(const TappedToPayEvent())
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: state.selectedPlan != null
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

  Widget _buildSubscriptionPlan(
    BuildContext context,
    String title,
    String price,
    String value, {
    bool highlight = false,
  }) {
    return BlocBuilder<SubscriptionPageBloc, SubscriptionPageState>(
      builder: (_, state) {
        final isSelected = state.selectedPlan == value;

        return GestureDetector(
          onTap: () => context
              .read<SubscriptionPageBloc>()
              .add(SelectOptionEvent(value)),
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
                      : (highlight
                          ? ColorConstants.primary
                          : Colors.pinkAccent),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
      },
    );
  }
}
