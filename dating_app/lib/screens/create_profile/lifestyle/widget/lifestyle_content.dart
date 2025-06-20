import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/list_constant.dart';
import 'package:dating_app/core/constants/text_constants.dart';
import 'package:dating_app/core/service/shared_perference_service.dart';
import 'package:dating_app/core/utilis/snackbar/ShowToast.dart';
import 'package:dating_app/screens/common_widget/loading_widget.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:dating_app/screens/create_profile/common_widget/dot_indicator.dart';
import 'package:dating_app/screens/create_profile/lifestyle/bloc/lifestyle_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LifestyleDetailsContent extends StatelessWidget {
  const LifestyleDetailsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LifestylePageBloc, LifestylePageState>(
      listenWhen: (previous, current) =>
          current is LifestylePageSuccessState ||
          current is LifestylePageErrorState,
      listener: (context, state) {
        if (state is LifestylePageSuccessState) {
          ShowToast.display(
              message: LifestylePageText.successMessage,
              backgroundColor: Colors.green);
        } else if (state is LifestylePageErrorState) {
          ShowToast.display(message: "Error: ${state.message}");
        }
      },
      child: Stack(
        children: [
          _buildMainBody(context),
          BlocBuilder<LifestylePageBloc, LifestylePageState>(
            buildWhen: (previous, current) =>
                current is LifestylePageLoadingState,
            builder: (context, state) {
              if (state is LifestylePageLoadingState) {
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
    final bloc = BlocProvider.of<LifestylePageBloc>(context);

    return BlocBuilder<LifestylePageBloc, LifestylePageState>(
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DotIndicatorWidget(currentIndex: 4, shouldSkip: false),
                const SizedBox(
                  height: 30,
                ),
                const TextWidget(
                    title: LifestylePageText.lifestyleTitle,
                    textSize: 23,
                    textColor: ColorConstants.primary,
                    boldness: FontWeight.bold),
                const TextWidget(
                    title: LifestylePageText.lifestyleSubtitle,
                    textSize: 14,
                    textColor: ColorConstants.grey,
                    boldness: FontWeight.w400),
                const SizedBox(height: 20),
                _buildYesNoField(
                  context,
                  LifestylePageText.doYouSmoke,
                  bloc.smoking,
                  (val) => bloc.add(UpdateSmokingEvent(smoking: val ?? false)),
                ),
                _buildYesNoField(
                  context,
                  LifestylePageText.doYouDrink,
                  bloc.drinking,
                  (val) =>
                      bloc.add(UpdateDrinkingEvent(drinking: val ?? false)),
                ),
                _buildYesNoField(
                  context,
                  LifestylePageText.havePets,
                  bloc.pets,
                  (val) => bloc.add(UpdatePetsEvent(pets: val ?? false)),
                ),
                _buildYesNoField(
                  context,
                  LifestylePageText.wantKids,
                  bloc.wantsKids,
                  (val) =>
                      bloc.add(UpdateWantsKidsEvent(wantsKids: val ?? false)),
                ),
                const SizedBox(height: 10),
                _buildDropdown(
                  context,
                  LifestylePageText.dietaryPreference,
                  ListConstant.dietaryPreference,
                  bloc.dietaryPreference?.isEmpty ?? true
                      ? null
                      : bloc.dietaryPreference,
                  (val) => bloc.add(UpdateDietaryPreferenceEvent(
                      dietaryPreference: val ?? "")),
                ),
                _buildDropdown(
                  context,
                  LifestylePageText.relationshipGoal,
                  ListConstant.relationshipTypes,
                  bloc.relationshipGoal?.isEmpty ?? true
                      ? null
                      : bloc.relationshipGoal,
                  (val) => bloc.add(
                      UpdateRelationshipGoalEvent(relationshipGoal: val ?? "")),
                ),
                _buildDropdown(
                  context,
                  LifestylePageText.religion,
                  ListConstant.religionAndBeliefOptions,
                  bloc.religion?.isEmpty ?? true ? null : bloc.religion,
                  (val) => bloc.add(UpdateReligionEvent(religion: val ?? "")),
                ),
                _buildDropdown(
                  context,
                  LifestylePageText.sleepSchedule,
                  ListConstant.sleepSchedule,
                  bloc.sleepSchedule?.isEmpty ?? true
                      ? null
                      : bloc.sleepSchedule,
                  (val) => bloc
                      .add(UpdateSleepScheduleEvent(sleepSchedule: val ?? "")),
                ),
                _buildDropdown(
                  context,
                  LifestylePageText.fitnessLevel,
                  ListConstant.fitnessLevels,
                  bloc.fitnessLevel?.isEmpty ?? true ? null : bloc.fitnessLevel,
                  (val) => bloc
                      .add(UpdateFitnessLevelEvent(fitnessLevel: val ?? "")),
                ),
                const SizedBox(height: 30),
                _buildSubmitButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildYesNoField(BuildContext context, String label, bool? value,
      ValueChanged<bool?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              offset: Offset(3, 2),
              color: Colors.pinkAccent,
              blurRadius: 1,
            )
          ],
          border: Border.all(color: ColorConstants.primary, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                title: label,
                boldness: FontWeight.bold,
                textSize: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<bool>(
                      title: const Text(LifestylePageText.yes),
                      value: true,
                      groupValue: value,
                      onChanged: onChanged,
                      activeColor: ColorConstants.primary,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<bool>(
                      title: const Text(LifestylePageText.no),
                      value: false,
                      groupValue: value,
                      onChanged: onChanged,
                      activeColor: ColorConstants.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(BuildContext context, String label,
      List<String> options, String? value, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
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
                  ? Text("Select your $label",
                      style: const TextStyle(color: ColorConstants.grey))
                  : const Text(""),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: ColorConstants.textFieldBorder.withOpacity(0.4)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: ColorConstants.primary),
              ),
              filled: true,
              fillColor: ColorConstants.textFieldBackground,
              hintStyle: const TextStyle(
                color: ColorConstants.grey,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    final bloc = BlocProvider.of<LifestylePageBloc>(context);

    return BlocBuilder<LifestylePageBloc, LifestylePageState>(
      buildWhen: (previous, current) => current is NextPageEnabledChangedState,
      builder: (context, state) {
        final isEnabled = state is NextPageEnabledChangedState
            ? state.isEnabled
            : bloc.isNextEnabled;

        return InkWell(
          onTap: isEnabled
              ? () {
                  bloc.add(SubmitLifestyleDetailsEvent(
                      userId: SharedPrefsService.getUserID().toString()));
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
