import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/text_constants.dart';
import 'package:dating_app/screens/common_widget/textFormField.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:flutter/material.dart';

class EditProfileContent extends StatefulWidget {
  const EditProfileContent({super.key});

  @override
  State<EditProfileContent> createState() => _EditProfileContentState();
}

class _EditProfileContentState extends State<EditProfileContent> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  String? selectedGender;
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  final List<String> allInterests = [
    'Music',
    'Travel',
    'Fitness',
    'Art',
    'Movies',
    'Cooking'
  ];
  List<String> selectedInterests = [];

  void _saveProfile() {
    final updatedProfile = {
      'name': nameController.text,
      'age': int.tryParse(ageController.text),
      'bio': bioController.text,
      'gender': selectedGender,
      'location': locationController.text,
      'occupation': occupationController.text,
      'interests': selectedInterests,
    };

    print('Updated Profile: $updatedProfile');
    // TODO: Send to backend or BLoC
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primary,
        title: const TextWidget(
          title: "Edit Profile",
          boldness: FontWeight.bold,
          textColor: ColorConstants.white,
          textSize: 22,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _saveProfile,
            icon: const Icon(Icons.save, color: ColorConstants.white),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWidget(
              title: "Bio",
              placeholder: "Something about you",
              errorText: "Bio is required",
              obscureText: false,
              controller: bioController,
              onTextChanged: () {},
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 10),
            TextFieldWidget(
              title: "Location",
              placeholder: "Enter your location",
              errorText: TextConstants.emailErrorText,
              obscureText: false,
              controller: locationController,
              onTextChanged: () {},
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            TextFieldWidget(
              title: "Occupation",
              placeholder: "Enter your occupation",
              errorText: TextConstants.emailErrorText,
              obscureText: false,
              controller: occupationController,
              onTextChanged: () {},
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            const TextWidget(
              title: "Interests",
              textColor: ColorConstants.primary,
              boldness: FontWeight.w600,
              textSize: 16,
            ),
            Wrap(
              spacing: 8,
              children: allInterests.map((interest) {
                final isSelected = selectedInterests.contains(interest);
                return FilterChip(
                  label: Text(interest),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedInterests.add(interest);
                      } else {
                        selectedInterests.remove(interest);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const TextWidget(
                  title: "Save",
                  textColor: ColorConstants.white,
                  boldness: FontWeight.bold,
                  textSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
