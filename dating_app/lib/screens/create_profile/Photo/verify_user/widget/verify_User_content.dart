import 'dart:io';
import 'package:dating_app/screens/create_profile/Photo/verify_user/widget/ShowPhotoUploadBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';

class VerifyUserContent extends StatefulWidget {
  const VerifyUserContent({super.key});

  @override
  State<VerifyUserContent> createState() => _VerifyUserContentState();
}

class _VerifyUserContentState extends State<VerifyUserContent> {
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: source, imageQuality: 85);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceActionSheet() async {
    await showPhotoUploadBottomSheet(context, (source) {
      _pickImage(source);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepIndicator(),
            const SizedBox(height: 30),
            const TextWidget(
              title: "Verify yourself",
              textSize: 24,
              textColor: ColorConstants.primary,
              boldness: FontWeight.bold,
            ),
            const SizedBox(height: 8),
            const TextWidget(
              title: "Take a selfie to verify yourself.",
              textSize: 16,
              textColor: ColorConstants.grey,
            ),
            const SizedBox(height: 12),
            const Text(
              "The selfie you will take for verification won’t be shared in your profile.",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 40),

            // Centered image avatar
            _createAvatar(
              _selectedImage,
              _showImageSourceActionSheet,
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      children: List.generate(4, (index) {
        return Container(
          margin: const EdgeInsets.only(right: 8),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == 2 ? ColorConstants.primary : Colors.grey.shade300,
          ),
        );
      }),
    );
  }
}

Widget _createAvatar(File? _selectedImage,
    GestureTapCallback _showImageSourceActionSheet, BuildContext context) {
  final size = MediaQuery.of(context).size;
  return Center(
    child: GestureDetector(
      onTap: _showImageSourceActionSheet,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: ColorConstants.primary, // Customize border color
            width: 5, // Border thickness
          ),
        ),
        child: CircleAvatar(
          radius: size.height * 0.2,
          backgroundColor: Colors.grey.shade200,
          backgroundImage:
              _selectedImage != null ? FileImage(_selectedImage!) : null,
          child: _selectedImage == null
              ? const Icon(Icons.add_a_photo, size: 40, color: Colors.grey)
              : null,
        ),
      ),
    ),
  );
}
