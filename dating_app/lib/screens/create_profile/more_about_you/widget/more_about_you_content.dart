import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/text_constants.dart';
import 'package:dating_app/screens/common_widget/loading_widget.dart';
import 'package:dating_app/screens/common_widget/textFormField.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:dating_app/screens/create_profile/personal_details/bloc/personal_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoreAboutYouContent extends StatefulWidget {
  @override
  _MoreAboutYouContentState createState() => _MoreAboutYouContentState();
}

class _MoreAboutYouContentState extends State<MoreAboutYouContent> {
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _twitterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Stack(
        children: [
          _createMainBody(context),
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

  Widget _createMainBody(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepIndicator(),
          const SizedBox(height: 30),
          const TextWidget(
              title: TextConstants.moreAboutYou,
              textSize: 25,
              textColor: ColorConstants.primary,
              boldness: FontWeight.bold),
          const TextWidget(
              title: "Just a few more details about you",
              textSize: 16,
              textColor: ColorConstants.grey,
              boldness: FontWeight.w400),
          const SizedBox(height: 20),
          _buildTextField("Occupation", _occupationController),
          _buildTextField("Education", _educationController),
          _buildTextField("Location", _locationController),
          const SizedBox(height: 20),
          const TextWidget(
              title: "Connect with others on social media.",
              textSize: 16,
              textColor: ColorConstants.primary,
              boldness: FontWeight.bold),
          const TextWidget(
              title: "You can skip and add it later",
              textSize: 14,
              textColor: ColorConstants.grey,
              boldness: FontWeight.normal),
          const SizedBox(height: 10),
          _buildTextField("Enter your Instagram handle", _instagramController),
          _buildTextField("Enter your Twitter handle", _twitterController),
          _buildNextButton(context),
        ],
      ),
    ));
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFieldWidget(
        title: label,
        placeholder: label,
        errorText: "Please enter $label",
        obscureText: false,
        isError: false,
        controller: controller,
        onTextChanged: () {},
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(4, (index) {
        return Container(
          margin: const EdgeInsets.only(right: 8),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == 1 ? ColorConstants.primary : Colors.grey.shade300,
          ),
        );
      }),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    final bloc = BlocProvider.of<PersonalDetailsBloc>(context);
    return BlocBuilder<PersonalDetailsBloc, PersonalDetailsState>(
      builder: (context, state) {
        final isEnabled =
            true ?? state is NextPageEnabledChangedState && state.isEnabled;

        return InkWell(
          onTap: isEnabled
              ? () {
                  bloc.add(NextPageUploadPhotoTapped());
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
