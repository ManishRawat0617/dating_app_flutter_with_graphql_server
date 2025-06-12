import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/text_constants.dart';
import 'package:dating_app/core/constants/utilis.dart';
import 'package:dating_app/screens/common_widget/loading_widget.dart';
import 'package:dating_app/screens/common_widget/textFormField.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:dating_app/screens/create_profile/common_widget/dot_indicator.dart';
import 'package:dating_app/screens/create_profile/bloc/personal_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoreAboutYouContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Stack(
        children: [
          _createMainBody(context),

          // Display loading indicator when the bloc emits LoadingState
          BlocBuilder<PersonalDetailsBloc, PersonalDetailsState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return LoadingWidget();
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }

  // Builds the main scrollable body content
  Widget _createMainBody(BuildContext context) {
    final bloc = BlocProvider.of<PersonalDetailsBloc>(context);

    // Get text controllers from BLoC
    final _occupationController = bloc.occupationController;
    final _locationController = bloc.locationController;
    final _instagramController = bloc.instagramController;

    const double spaceBtwWidget = 10;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step indicator with current page index
              const DotIndicatorWidget(
                currentIndex: 1,
                shouldSkip: true,
              ),

              SizedBox(height: Utilis.spaceBtwWidget * 3),

              // Title and subtitle
              const TextWidget(
                title: MoreAboutYouPageText.moreAboutYou,
                textSize: 25,
                textColor: ColorConstants.primary,
                boldness: FontWeight.bold,
              ),
              const TextWidget(
                title: MoreAboutYouPageText.moreAboutYou_subtitle,
                textSize: 16,
                textColor: ColorConstants.grey,
                boldness: FontWeight.w400,
              ),

              SizedBox(height: Utilis.spaceBtwWidget),

              // Occupation field
              _buildTextField(
                  context,
                  MoreAboutYouPageText.occupation,
                  MoreAboutYouPageText.occupationPlaceholder,
                  _occupationController),

              const SizedBox(height: spaceBtwWidget),

              // Location field
              _buildTextField(
                context,
                MoreAboutYouPageText.location,
                MoreAboutYouPageText.locationPlacholder,
                _locationController,
              ),

              SizedBox(height: Utilis.spaceBtwWidget),

              // Section heading for social media
              const TextWidget(
                title: MoreAboutYouPageText.connectWithOtherOnSocialMedia,
                textSize: 16,
                textColor: ColorConstants.primary,
                boldness: FontWeight.bold,
              ),
              const TextWidget(
                title: "You can skip and add it later",
                textSize: 14,
                textColor: ColorConstants.grey,
                boldness: FontWeight.normal,
              ),

              const SizedBox(height: 20),

              // Instagram handle input
              _buildTextField(
                context,
                MoreAboutYouPageText.instagram,
                MoreAboutYouPageText.instagramPlaceholder,
                _instagramController,
              ),

              SizedBox(height: Utilis.spaceBtwWidget * 3),

              // Next button
              _buildNextButton(context),
            ],
          ),
        ),
      ),
    );
  }

// textformfield widget
  Widget _buildTextField(BuildContext context, String label, String placeholder,
      TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    final bloc = BlocProvider.of<PersonalDetailsBloc>(context);

    return TextFieldWidget(
      title: label,
      placeholder: placeholder,
      errorText: "Please enter your $label",
      obscureText: false,
      isError: false,
      controller: controller,
      onTextChanged: () {
        bloc.add(OnTextChangedMoreAboutYou(
            occupation: bloc.occupationController.text,
            location: bloc.locationController.text));
      },
      textInputAction: TextInputAction.done,
      keyboardType: keyboardType,
    );
  }

  // Builds the "Next" button and handles click event
  Widget _buildNextButton(BuildContext context) {
    final bloc = BlocProvider.of<PersonalDetailsBloc>(context);

    return BlocBuilder<PersonalDetailsBloc, PersonalDetailsState>(
      builder: (context, state) {
        final isEnabled =
            state is NextPageEnabledChangedState && state.isEnabled;

        return InkWell(
          onTap: isEnabled
              ? () {
                  // Trigger event to save data and go to next page
                  bloc.add(NextPageQuickIntroductionTapped());
                }
              : null,
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: isEnabled ? ColorConstants.primary : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: TextWidget(
                title: "Next",
                textColor: Colors.white,
                textSize: 18,
                boldness: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
