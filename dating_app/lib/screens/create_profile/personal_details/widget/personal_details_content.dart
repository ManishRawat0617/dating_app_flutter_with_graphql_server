import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/list_constant.dart';
import 'package:dating_app/core/constants/text_constants.dart';
import 'package:dating_app/screens/common_widget/loading_widget.dart';
import 'package:dating_app/screens/common_widget/textFormField.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:dating_app/screens/create_profile/common_widget/dot_indicator.dart';
import 'package:dating_app/screens/create_profile/bloc/personal_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PersonalDetailsContent extends StatefulWidget {
  @override
  _PersonalDetailsContentState createState() => _PersonalDetailsContentState();
}

class _PersonalDetailsContentState extends State<PersonalDetailsContent> {
  String? _gender;

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
    const double spaceBtwWidget = 10;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DotIndicatorWidget(
                  currentIndex: bloc.currentIndex, shouldSkip: false),
              const SizedBox(height: 30),
              const TextWidget(
                  title: PersonalDetailsPageText.personalDetails,
                  textSize: 25,
                  textColor: ColorConstants.primary,
                  boldness: FontWeight.bold),
              const TextWidget(
                  title: PersonalDetailsPageText.fillInYourDetails,
                  textSize: 16,
                  textColor: ColorConstants.grey,
                  boldness: FontWeight.w400),
              const SizedBox(height: 20),
              _buildTextField(
                  PersonalDetailsPageText.firstName,
                  PersonalDetailsPageText.firstNamePlaceholder,
                  bloc.firstNameController),
              const SizedBox(
                height: spaceBtwWidget,
              ),
              _buildTextField(
                  PersonalDetailsPageText.lastName,
                  PersonalDetailsPageText.lastNamePlaceholder,
                  bloc.lastNameController),
              const SizedBox(
                height: spaceBtwWidget,
              ),
              buildDatePickerField(
                label: "Date of Birth",
                hint: "YYYY-MM-DD",
                controller: bloc.dateOfBirthController,
                context: context,
              ),
              const SizedBox(
                height: spaceBtwWidget,
              ),
              _buildDropdown(PersonalDetailsPageText.gender,
                  ListConstant.genderList, _gender, (val) {
                final bloc = BlocProvider.of<PersonalDetailsBloc>(context);
                setState(() {
                  _gender = val;
                  bloc.genderController.text = val ?? '';
                });

                bloc.add(OnTextChangedPersonalDetails(
                  firstName: bloc.firstNameController.text,
                  lastName: bloc.lastNameController.text,
                  age: bloc.ageController.text,
                  dateOfBirth: bloc.dateOfBirthController.text,
                  gender: bloc.genderController.text,
                ));
              }),
              const SizedBox(
                height: spaceBtwWidget + 8,
              ),
              const TextWidget(
                title: PersonalDetailsPageText.age,
                textColor: ColorConstants.primary,
                textSize: 14,
                boldness: FontWeight.bold,
              ),
              const SizedBox(
                height: 5,
              ),
              TextWidget(
                title: bloc.ageController.text.toString(),
                textColor: ColorConstants.textColor1,
                textSize: 18,
                boldness: FontWeight.bold,
              ),
              // _buildTextField(PersonalDetailsPageText.age,
              //     PersonalDetailsPageText.agePlaceholder, bloc.ageController,
              //     keyboardType: TextInputType.number),
              // const SizedBox(
              //   height: spaceBtwWidget * 4,
              // ),
              const SizedBox(
                height: spaceBtwWidget * 4,
              ),
              _buildNextButton(context),
            ],
          ),
        ),
      ),
    );
  }

// textformfield widget
  Widget _buildTextField(
      String label, String placeholder, TextEditingController controller,
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
        bloc.add(OnTextChangedPersonalDetails(
          firstName: bloc.firstNameController.text,
          lastName: bloc.lastNameController.text,
          age: bloc.ageController.text,
          dateOfBirth: bloc.dateOfBirthController.text,
          gender: bloc.genderController.text,
        ));
      },
      textInputAction: TextInputAction.done,
      keyboardType: keyboardType,
    );
  }

// dropdown menu
  Widget _buildDropdown(String label, List<String> options, String? value,
      void Function(String?) onChanged) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          title: label,
          textColor: ColorConstants.primary,
          textSize: 14,
          boldness: FontWeight.bold,
        ),
        const SizedBox(
          height: 5,
        ),
        DropdownButtonFormField<String>(
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
            // hintText: widget.placeholder,
            hintStyle: const TextStyle(
              color: ColorConstants.grey,
              fontSize: 16,
            ),
            filled: true,
            fillColor: ColorConstants.textFieldBackground,
          ),
        ),
      ],
    );
  }

  Widget buildDatePickerField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          title: label,
          textColor: ColorConstants.primary,
          textSize: 14,
          boldness: FontWeight.bold,
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
            controller: controller,
            readOnly: true,
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.calendar_today),
              suffixIconColor: ColorConstants.primary,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                    color: ColorConstants.textFieldBorder.withOpacity(0.4)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: ColorConstants.primary,
                ),
              ),
              hintText: hint,
              hintStyle: const TextStyle(
                color: ColorConstants.grey,
                fontSize: 16,
              ),
              filled: true,
              fillColor: ColorConstants.textFieldBackground,
            ),
            onTap: () async {
              FocusScope.of(context).unfocus(); // close keyboard

              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime(2000),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                controller.text = formattedDate;

                // Calculate age
                final today = DateTime.now();
                int age = today.year - pickedDate.year;
                if (today.month < pickedDate.month ||
                    (today.month == pickedDate.month &&
                        today.day < pickedDate.day)) {
                  age--;
                }

                // Set age to the bloc's ageController
                final bloc = BlocProvider.of<PersonalDetailsBloc>(context);
                bloc.ageController.text = age.toString();

                // Trigger event to update state
                bloc.add(OnTextChangedPersonalDetails(
                  firstName: bloc.firstNameController.text,
                  lastName: bloc.lastNameController.text,
                  age: bloc.ageController.text,
                  dateOfBirth: bloc.dateOfBirthController.text,
                  gender: bloc.genderController.text,
                ));
              }
            }),
      ],
    );
  }

// change the page
  Widget _buildNextButton(BuildContext context) {
    final bloc = BlocProvider.of<PersonalDetailsBloc>(context);
    return BlocBuilder<PersonalDetailsBloc, PersonalDetailsState>(
      builder: (context, state) {
        final isEnabled =
            state is NextPageEnabledChangedState && state.isEnabled;

        return InkWell(
          onTap: isEnabled
              ? () {
                  bloc.add(const NextPageMoreAboutYouTapped());
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
                title: TextConstants.next,
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
