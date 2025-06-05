import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';

class UploadImageContent extends StatefulWidget {
  const UploadImageContent({super.key});

  @override
  State<UploadImageContent> createState() => _UploadImageContentState();
}

class _UploadImageContentState extends State<UploadImageContent> {
  final List<File> _selectedImages = [];

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: source, imageQuality: 85);
    if (pickedFile != null && _selectedImages.length < 3) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Container(
          height: 180,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a selfie'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Upload from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        ),
      ),
    );
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
              title: "Upload your images",
              textSize: 24,
              textColor: ColorConstants.primary,
              boldness: FontWeight.bold,
            ),
            const SizedBox(height: 12),
            const Text(
              "The images will be shared in your profile.",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            _buildImageGrid(),
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

  Widget _buildImageGrid() {
    List<Widget> gridItems = [];

    // Add selected images
    for (var image in _selectedImages) {
      gridItems.add(Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: FileImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ));
    }

    // Add add-image placeholder if less than 2
    if (_selectedImages.length < 3) {
      gridItems.add(
        GestureDetector(
          onTap: _showImageSourceActionSheet,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: gridItems,
    );
  }
}
