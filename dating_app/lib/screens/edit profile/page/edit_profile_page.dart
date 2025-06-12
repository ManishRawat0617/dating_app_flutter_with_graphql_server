import 'package:dating_app/screens/edit%20profile/widget/edit_profile_content.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  String? selectedGender;
  List<String> genderOptions = ['Male', 'Female', 'Other'];

  List<String> selectedInterests = [];
  List<String> allInterests = [
    'Music',
    'Travel',
    'Fitness',
    'Art',
    'Movies',
    'Cooking'
  ];

  @override
  void initState() {
    super.initState();
    // Pre-fill with existing values from shared preferences or API
    _nameController.text = 'John Doe';
    _ageController.text = '24';
    _bioController.text = 'Love traveling and music.';
    _locationController.text = 'New York';
    selectedGender = 'Male';
    selectedInterests = ['Music', 'Travel'];
  }

  void _saveProfile() {
    // Save to BLoC, Provider or directly via API
    final updatedProfile = {
      'name': _nameController.text,
      'age': int.tryParse(_ageController.text),
      'bio': _bioController.text,
      'gender': selectedGender,
      'location': _locationController.text,
      'interests': selectedInterests,
    };
    print(updatedProfile); // Replace with actual logic
  }

  @override
  Widget build(BuildContext context) {
    return EditProfileContent();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Edit Profile'),
    //     actions: [
    //       IconButton(
    //         icon: const Icon(Icons.save),
    //         onPressed: _saveProfile,
    //       )
    //     ],
    //   ),
    //   body: SingleChildScrollView(
    //     padding: const EdgeInsets.all(16),
    //     child: Column(
    //       children: [
    //         TextField(
    //           controller: _nameController,
    //           decoration: const InputDecoration(labelText: 'Name'),
    //         ),
    //         TextField(
    //           controller: _ageController,
    //           keyboardType: TextInputType.number,
    //           decoration: const InputDecoration(labelText: 'Age'),
    //         ),
    //         TextField(
    //           controller: _bioController,
    //           maxLines: 3,
    //           decoration: const InputDecoration(labelText: 'Bio'),
    //         ),
    //         DropdownButtonFormField<String>(
    //           value: selectedGender,
    //           decoration: const InputDecoration(labelText: 'Gender'),
    //           items: genderOptions.map((gender) {
    //             return DropdownMenuItem(
    //               value: gender,
    //               child: Text(gender),
    //             );
    //           }).toList(),
    //           onChanged: (value) => setState(() => selectedGender = value),
    //         ),
    //         TextField(
    //           controller: _locationController,
    //           decoration: const InputDecoration(labelText: 'Location'),
    //         ),
    //         const SizedBox(height: 16),
    //         const Align(
    //           alignment: Alignment.centerLeft,
    //           child: Text('Interests',
    //               style: TextStyle(fontWeight: FontWeight.bold)),
    //         ),
    //         Wrap(
    //           spacing: 8.0,
    //           children: allInterests.map((interest) {
    //             final isSelected = selectedInterests.contains(interest);
    //             return FilterChip(
    //               label: Text(interest),
    //               selected: isSelected,
    //               onSelected: (selected) {
    //                 setState(() {
    //                   if (selected) {
    //                     selectedInterests.add(interest);
    //                   } else {
    //                     selectedInterests.remove(interest);
    //                   }
    //                 });
    //               },
    //             );
    //           }).toList(),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
