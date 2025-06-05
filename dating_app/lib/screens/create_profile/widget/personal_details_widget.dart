import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/list_constant.dart';
import 'package:dating_app/screens/common_widget/loading_widget.dart';
import 'package:dating_app/screens/common_widget/textFormField.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:dating_app/screens/create_profile/personal_details/bloc/personal_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalDetailsWidget extends StatefulWidget {
  @override
  _PersonalDetailsWidgetState createState() => _PersonalDetailsWidgetState();
}

class _PersonalDetailsWidgetState extends State<PersonalDetailsWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  String? _gender;
  String? _pronouns;
  String? _orientation;

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
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepIndicator(),
            const SizedBox(height: 30),
            const TextWidget(
                title: "Personal details",
                textSize: 25,
                textColor: ColorConstants.primary,
                boldness: FontWeight.bold),
            const TextWidget(
                title: "Fill in your details so people know you better.",
                textSize: 16,
                textColor: ColorConstants.grey,
                boldness: FontWeight.w400),
            const SizedBox(height: 20),
            _buildTextField("First name", _nameController),
            const SizedBox(
              height: 5,
            ),
            _buildTextField("Last name", _nameController),
            const SizedBox(
              height: 5,
            ),
            _buildTextField("MM / DD / YYYY", _dobController,
                keyboardType: TextInputType.datetime),
            const SizedBox(
              height: 5,
            ),
            _buildDropdown("Gender", ListConstant.genderList, _gender, (val) {
              setState(() => _gender = val);
            }),
            const SizedBox(
              height: 5,
            ),
            _buildDropdown("Pronouns", ListConstant.pronounsList, _pronouns,
                (val) {
              setState(() => _pronouns = val);
            }),
            const SizedBox(
              height: 5,
            ),
            _buildDropdown("Sexual orientation",
                ListConstant.sexualOrientationList, _orientation, (val) {
              setState(() => _orientation = val);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(4, (index) {
        return Container(
          margin: EdgeInsets.only(right: 8),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == 0 ? ColorConstants.primary : Colors.grey.shade300,
          ),
        );
      }),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFieldWidget(
      title: label,
      placeholder: label,
      errorText: "Please enter your $label",
      obscureText: false,
      isError: false,
      controller: controller,
      onTextChanged: () {},
      textInputAction: TextInputAction.done,
      keyboardType: keyboardType,
    );
  }

  Widget _buildDropdown(String label, List<String> options, String? value,
      void Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            title: label,
            textColor: ColorConstants.primary,
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
                      style: TextStyle(color: ColorConstants.grey),
                    )
                  : Text(""),
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
      ),
    );
  }
}
