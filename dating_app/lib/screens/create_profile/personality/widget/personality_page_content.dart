// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dating_app/screens/create_profile/common_widget/dot_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/list_constant.dart';
import 'package:dating_app/core/constants/text_constants.dart';
import 'package:dating_app/core/utilis/snackbar/ShowToast.dart';
import 'package:dating_app/screens/common_widget/loading_widget.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:dating_app/screens/create_profile/personality/bloc/personality_page_bloc.dart';

class PersonalityDetailsContent extends StatelessWidget {
  String personalityType;
  PersonalityDetailsContent({
    Key? key,
    required this.personalityType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PersonalityPageBloc>().add(
            UpdatePersonalityTypeEvent(personalityType: personalityType),
          );
    });
    return BlocListener<PersonalityPageBloc, PersonalityPageState>(
      listenWhen: (previous, current) =>
          current is PersonalityPageSuccessState ||
          current is PersonalityPageErrorState,
      listener: (context, state) {
        if (state is PersonalityPageSuccessState) {
          ShowToast.display(
              message: LifestylePageText.successMessage,
              backgroundColor: Colors.green);
        } else if (state is PersonalityPageErrorState) {
          ShowToast.display(message: "Error: ${state.message}");
        }
      },
      child: Stack(
        children: [
          _buildMainBody(context),
          BlocBuilder<PersonalityPageBloc, PersonalityPageState>(
            buildWhen: (previous, current) =>
                current is PersonalityPageLoadingState,
            builder: (context, state) {
              if (state is PersonalityPageLoadingState) {
                return LoadingWidget();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMainBody(BuildContext context) {
    return BlocBuilder<PersonalityPageBloc, PersonalityPageState>(
      builder: (context, state) {
        final bloc = context.read<PersonalityPageBloc>();
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DotIndicatorWidget(currentIndex: 6, shouldSkip: false),
                const SizedBox(
                  height: 30,
                ),

                const TextWidget(
                  title: "Personality Type",
                  textColor: ColorConstants.primary,
                  boldness: FontWeight.bold,
                  textAlign: TextAlign.left,
                ),
                TextWidget(
                  title: bloc.personalityType.toString(),
                  textSize: 16,
                  textColor: Colors.black,
                  boldness: FontWeight.w500,
                  textAlign: TextAlign.left,
                ),

                //  bloc.add(UpdatePersonalityTypeEvent(personalityType: personalityType)),
                // _buildDropdown(
                //   context,
                //   label: PersonalityPageText.personalityType,
                //   options: ListConstant.personalityTypes,
                //   value: bloc.personalityType,
                //   onChanged: (val) =>
                //       bloc.add(UpdatePersonalityTypeEvent(personalityType: val!)),
                // ),
                _buildDropdown(
                  context,
                  label: PersonalityPageText.zodiacSign,
                  options: ListConstant.zodiacSigns,
                  value: bloc.zodiacSign,
                  onChanged: (val) =>
                      bloc.add(UpdateZodiacSignEvent(zodiacSign: val!)),
                ),
                _buildDropdown(
                  context,
                  label: PersonalityPageText.politicalView,
                  options: ListConstant.politicalViews,
                  value: bloc.politicalView,
                  onChanged: (val) =>
                      bloc.add(UpdatePoliticalViewEvent(politicalView: val!)),
                ),
                _buildDropdown(
                  context,
                  label: PersonalityPageText.loveLanguage,
                  options: ListConstant.loveLanguages,
                  value: bloc.loveLanguage,
                  onChanged: (val) =>
                      bloc.add(UpdateLoveLanguageEvent(loveLanguage: val!)),
                ),
                _buildDropdown(
                  context,
                  label: PersonalityPageText.humorStyle,
                  options: ListConstant.humorStyles,
                  value: bloc.humorStyle,
                  onChanged: (val) =>
                      bloc.add(UpdateHumorStyleEvent(humorStyle: val!)),
                ),
                const SizedBox(height: 30),
                _buildSubmitButton(context)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDropdown(
    BuildContext context, {
    required String label,
    required List<String> options,
    required String? value,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            title: label,
            textColor: ColorConstants.primary,
            textSize: 15,
            boldness: FontWeight.bold,
          ),
          const SizedBox(height: 7),
          DropdownButtonFormField<String>(
            value: value,
            items: options
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: TextWidget(
                        title: e,
                        textSize: 17,
                        textColor: ColorConstants.primary,
                      ),
                    ))
                .toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              label: value == null
                  ? Text(
                      "Select your $label",
                      style: const TextStyle(color: ColorConstants.grey),
                    )
                  : const Text(""),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: ColorConstants.textFieldBorder.withOpacity(0.4),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: ColorConstants.primary,
                ),
              ),
              filled: true,
              fillColor: ColorConstants.textFieldBackground,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    final bloc = BlocProvider.of<PersonalityPageBloc>(context);

    return BlocBuilder<PersonalityPageBloc, PersonalityPageState>(
      buildWhen: (previous, current) => current is NextPageEnabledChangedState,
      builder: (context, state) {
        final isEnabled = state is NextPageEnabledChangedState
            ? state.isEnabled
            : bloc.isNextEnabled;

        return InkWell(
          onTap: isEnabled
              ? () {
                  bloc.add(SubmitPersonalityDetailsEvent(
                      // userId: SharedPrefsService.getUserID().toString()
                      ));
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
                title: TextConstants.save,
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
