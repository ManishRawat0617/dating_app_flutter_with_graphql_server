import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/list_constant.dart';
import 'package:dating_app/core/constants/text_constants.dart';
import 'package:dating_app/core/service/shared_perference_service.dart';
import 'package:dating_app/screens/common_widget/loading_widget.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:dating_app/screens/create_profile/common_widget/dot_indicator.dart';
import 'package:dating_app/screens/create_profile/bloc/personal_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPreferencesContent extends StatefulWidget {
  @override
  _UserPreferencesContentState createState() => _UserPreferencesContentState();
}

class _UserPreferencesContentState extends State<UserPreferencesContent> {
  String? _selectedGender;
  String? _selectedRelationship;
  String? _selectedReligion;

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
            buildWhen: (prev, curr) =>
                curr is LoadingState || curr is ErrorState,
            builder: (context, state) {
              if (state is LoadingState) {
                return LoadingWidget();
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _createMainBody(BuildContext context) {
    final bloc = BlocProvider.of<PersonalDetailsBloc>(context);
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DotIndicatorWidget(currentIndex: 3, shouldSkip: false),
            const SizedBox(height: 30),
            const TextWidget(
              title: YourPreferencePageText.yourPerference,
              textSize: 25,
              textColor: ColorConstants.primary,
              boldness: FontWeight.bold,
            ),
            const SizedBox(height: 30),
            _buildDropdown(
              YourPreferencePageText.typeOfRelationship,
              ListConstant.relationshipTypes,
              _selectedRelationship,
              (val) {
                setState(() {
                  _selectedRelationship = val;
                  bloc.typeOfRelationshipInterestedInController = val;
                });
              },
            ),
            const SizedBox(height: 30),
            _buildAgeRangeSelector(),
            const SizedBox(height: 10),
            _buildDistanceSelector(),
            const SizedBox(height: 20),
            _buildDropdown(
              YourPreferencePageText.genderInterstedIn,
              ListConstant.genderList,
              _selectedGender,
              (val) {
                setState(() {
                  _selectedGender = val;
                  bloc.interestedGenderInController = val ?? '';
                });
              },
            ),
            const SizedBox(height: 20),
            _buildDropdown(
              YourPreferencePageText.religionInterstedIn,
              ListConstant.religionAndBeliefOptions,
              _selectedReligion,
              (val) {
                setState(() {
                  _selectedReligion = val;
                  bloc.interestedReligionInController = val;

                  bloc.add(OnTextChangedUserPreference(
                    typeOfRelationshipInterestedIn:
                        bloc.typeOfRelationshipInterestedInController ?? '',
                    interestedGenderIn: bloc.interestedGenderInController ?? '',
                    interestedReligionIn:
                        bloc.interestedReligionInController ?? '',
                    interestedInAgeRange:
                        "${bloc.interestedInAgeRangeController.start.round()}-${bloc.interestedInAgeRangeController.end.round()}",
                    interestedInDistance:
                        (bloc.interestedInDistanceController ?? 0)
                            .round()
                            .toString(),
                  ));
                });
              },
            ),
            const SizedBox(height: 30),
            _buildNextButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAgeRangeSelector() {
    final bloc = BlocProvider.of<PersonalDetailsBloc>(context);
    return BlocBuilder<PersonalDetailsBloc, PersonalDetailsState>(
      buildWhen: (previous, current) =>
          current is AgeRangeUpdatedState ||
          current is CreateProfileInitialState,
      builder: (context, state) {
        final ageRange = bloc.interestedInAgeRangeController;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextWidget(
                  title: YourPreferencePageText.ageRange,
                  textSize: 16,
                  textColor: ColorConstants.primary,
                ),
                Text(
                  "${ageRange.start.round()} - ${ageRange.end.round()}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primary,
                  ),
                ),
              ],
            ),
            RangeSlider(
              values: ageRange,
              min: 18,
              max: 100,
              divisions: 82,
              labels: RangeLabels(
                ageRange.start.round().toString(),
                ageRange.end.round().toString(),
              ),
              activeColor: ColorConstants.primary,
              onChanged: (values) {
                bloc.add(AgeRangeChanged(values));
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDistanceSelector() {
    final bloc = BlocProvider.of<PersonalDetailsBloc>(context);
    return BlocBuilder<PersonalDetailsBloc, PersonalDetailsState>(
      buildWhen: (previous, current) =>
          current is DistanceUpdateState ||
          current is CreateProfileInitialState,
      builder: (context, state) {
        final _distance = bloc.interestedInDistanceController ?? 0;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextWidget(
                    title: YourPreferencePageText.distance,
                    textSize: 16,
                    textColor: ColorConstants.primary),
                Text(
                  "${_distance.round()} Km",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primary,
                  ),
                ),
              ],
            ),
            Slider(
              value: _distance,
              min: 0,
              max: 100,
              divisions: 99,
              label: "${_distance.round()} Km",
              activeColor: ColorConstants.primary,
              onChanged: (val) {
                bloc.add(DistanceChanged(val));
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDropdown(String label, List<String> options, String? value,
      void Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          title: label,
          textColor: ColorConstants.primary,
        ),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: value,
          items: options
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: TextStyle(color: ColorConstants.primary),
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
    );
  }

  Widget _buildNextButton(BuildContext context) {
    final bloc = BlocProvider.of<PersonalDetailsBloc>(context);
    return BlocBuilder<PersonalDetailsBloc, PersonalDetailsState>(
      builder: (context, state) {
        final isEnabled =
            true ?? state is NextPageEnabledChangedState && state.isEnabled;

        return InkWell(
          // onTap: isEnabled
          //     ? () {
          //         bloc.add(NextPageUploadPhotoTapped());
          //       }
          //     : null,

          onTap: () {
             bloc.add(NextPageUploadPhotoTapped());
          },
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
