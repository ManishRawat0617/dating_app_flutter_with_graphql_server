import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/list_constant.dart';
import 'package:dating_app/core/service/shared_perference_service.dart';
import 'package:dating_app/screens/common_widget/loading_widget.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:dating_app/screens/create_profile/personal_details/bloc/personal_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPreferencesContent extends StatefulWidget {
  @override
  _UserPreferencesContentState createState() => _UserPreferencesContentState();
}

class _UserPreferencesContentState extends State<UserPreferencesContent> {
  String? _interestedIn;
  RangeValues _ageRange = const RangeValues(20, 32);
  double _distance = 20;
  String? _interestedGenderIn;
  String? _interestedReligionIn;

  @override
  Widget build(BuildContext context) {
    final spaceBtwWidgets = 10.0;
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
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepIndicator(),
            const SizedBox(height: 30),
            const TextWidget(
                title: "Your preferences",
                textSize: 25,
                textColor: ColorConstants.primary,
                boldness: FontWeight.bold),
            const SizedBox(height: 30),
            _buildTypeOfRelationship(),
            const SizedBox(height: 30),
            _buildAgeRangeSelector(),
            const SizedBox(height: 10),
            _buildDistanceSelector(),
            const SizedBox(height: 20),
            _buildTypeOfGenderInterestedIn(),
            const SizedBox(height: 20),
            _buildTypeOfReligionInterestedIn(),
            const SizedBox(height: 30),
            _buildNextButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      children: List.generate(5, (index) {
        return Container(
          margin: const EdgeInsets.only(right: 8),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == 3 ? ColorConstants.primary : Colors.grey.shade300,
          ),
        );
      }),
    );
  }

// type of relationship
  Widget _buildTypeOfRelationship() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidget(
            title: "Type of relationship you're looking for",
            textSize: 16,
            textColor: ColorConstants.primary,
            boldness: FontWeight.w400),
        const SizedBox(height: 10),
        _buildDropdown("Interested In", ListConstant.relationshipTypes,
            _interestedIn, (val) => setState(() => _interestedIn = val))
      ],
    );
  }

// Age range selector
  Widget _buildAgeRangeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextWidget(
                title: "Age Range",
                textSize: 16,
                textColor: ColorConstants.primary),
            Text(
              "${_ageRange.start.round()} - ${_ageRange.end.round()}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorConstants.primary,
              ),
            ),
          ],
        ),
        RangeSlider(
          values: _ageRange,
          min: 18,
          max: 100,
          divisions: 82,
          labels: RangeLabels(_ageRange.start.round().toString(),
              _ageRange.end.round().toString()),
          activeColor: ColorConstants.primary,
          onChanged: (values) {
            setState(() {
              _ageRange = values;
            });
          },
        )
      ],
    );
  }

// Distance selector
  Widget _buildDistanceSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextWidget(
                title: "Distance",
                textSize: 16,
                textColor: ColorConstants.primary),
            Text(
              "${_distance.round()} Km",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorConstants.primary,
              ),
            ),
          ],
        ),
        Slider(
          value: _distance,
          min: 1,
          max: 100,
          divisions: 99,
          label: "${_distance.round()} Km",
          activeColor: ColorConstants.primary,
          onChanged: (val) {
            setState(() => _distance = val);
          },
        ),
      ],
    );
  }

  // type of relationship
  Widget _buildTypeOfGenderInterestedIn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidget(
            title: "Gender Interested In",
            textSize: 16,
            textColor: ColorConstants.primary,
            boldness: FontWeight.w400),
        const SizedBox(height: 10),
        _buildDropdown(
            "Interested In",
            ListConstant.genderList,
            _interestedGenderIn,
            (val) => setState(() => _interestedGenderIn = val))
      ],
    );
  }

  // type of relationship
  Widget _buildTypeOfReligionInterestedIn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidget(
            title: "Religion Interested In",
            textSize: 16,
            textColor: ColorConstants.primary,
            boldness: FontWeight.w400),
        const SizedBox(height: 10),
        _buildDropdown(
            "Interested In",
            ListConstant.religionAndBeliefOptions,
            _interestedReligionIn,
            (val) => setState(() => _interestedReligionIn = val))
      ],
    );
  }

// Dropdown widget for selecting options
  Widget _buildDropdown(String label, List<String> options, String? value,
      void Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownButtonFormField<String>(
        value: value,
        items: options
            .map((e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: TextStyle(color: ColorConstants.primary),
                )))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          label: value == null
              ? Text(
                  "Select you $label",
                  style: TextStyle(color: ColorConstants.grey),
                )
              : null,
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
    );
  }

  Widget _buildNextButton(BuildContext context) {
    final bloc = BlocProvider.of<PersonalDetailsBloc>(context);
    return BlocBuilder<PersonalDetailsBloc, PersonalDetailsState>(
      builder: (context, state) {
        final isEnabled =
            state is NextPageEnabledChangedState && state.isEnabled;

        return InkWell(
          onTap: isEnabled
              ? () {
                  bloc.add(NextPageUserPreferencesTapped());
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
