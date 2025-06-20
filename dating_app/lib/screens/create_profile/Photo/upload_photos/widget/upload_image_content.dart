import 'dart:io';

import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/text_constants.dart';
import 'package:dating_app/core/utilis/snackbar/ShowToast.dart';
import 'package:dating_app/screens/common_widget/loading_widget.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:dating_app/screens/create_profile/Photo/upload_photos/bloc/upload_photo_bloc.dart';
import 'package:dating_app/screens/create_profile/Photo/upload_photos/bloc/upload_photo_event.dart';
import 'package:dating_app/screens/create_profile/Photo/upload_photos/bloc/upload_photo_state.dart';
import 'package:dating_app/screens/create_profile/Photo/upload_photos/widget/ShowPhotoUploadBottomSheet.dart';
import 'package:dating_app/screens/create_profile/common_widget/dot_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageContent extends StatefulWidget {
  const UploadImageContent({super.key});

  @override
  State<UploadImageContent> createState() => _UploadImageContentState();
}

class _UploadImageContentState extends State<UploadImageContent> {
  Future<void> _pickImage(ImageSource source) async {
    final bloc = context.read<UploadPhotoBloc>();
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: source, imageQuality: 85);

    if (pickedFile != null) {
      bloc.add(AddPhotoEvent(file: File(pickedFile.path)));
    }
  }

  void _showImageSourceActionSheet() async {
    await showPhotoUploadBottomSheet(context, (source) {
      _pickImage(source);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: Stack(
        children: [
          _createMainBody(context),
          BlocBuilder<UploadPhotoBloc, UploadPhotoState>(
            buildWhen: (_, curr) => curr is LoadingState,
            builder: (_, state) {
              return state is LoadingState ? LoadingWidget() : const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _createMainBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DotIndicatorWidget(currentIndex: 7, shouldSkip: false),
            const SizedBox(height: 30),
            const TextWidget(
              title: UploadPhotoPageText.title,
              textSize: 24,
              textColor: ColorConstants.primary,
              boldness: FontWeight.bold,
            ),
            const SizedBox(height: 12),
            const Text(
              UploadPhotoPageText.subtitle,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            BlocBuilder<UploadPhotoBloc, UploadPhotoState>(
              buildWhen: (_, curr) =>
                  curr is PhotoSelectedState ||
                  curr is UploadButtonEnabledChangedState,
              builder: (context, _) {
                final images = context.read<UploadPhotoBloc>().selectedImages;
                return _buildImageGrid(images);
              },
            ),
            const SizedBox(height: 10),
            _buildUploadButton()
          ],
        ),
      ),
    );
  }

  Widget _buildImageGrid(List<File> selectedImages) {
    List<Widget> gridItems =
        selectedImages.map((image) => _buildSelectedPhoto(image)).toList();

    if (selectedImages.length < 3) {
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

  Widget _buildSelectedPhoto(File image) {
    final bloc = context.read<UploadPhotoBloc>();

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: FileImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => bloc.add(RemovePhotoEvent(file: image)),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadButton() {
    final bloc = BlocProvider.of<UploadPhotoBloc>(context);
    return BlocBuilder<UploadPhotoBloc, UploadPhotoState>(
      buildWhen: (_, curr) => curr is UploadButtonEnabledChangedState,
      builder: (context, state) {
        final isEnabled =
            state is UploadButtonEnabledChangedState && state.isEnabled;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: isEnabled
                ? () {
                    final selectedImages =
                        context.read<UploadPhotoBloc>().selectedImages;
                    if (selectedImages.isEmpty) {
                      ShowToast.display(
                          message: "Please select at least one image");
                    } else {
                      bloc.add(TappedOnUploadPhoto());
                    }
                  }
                : null,
            child: Container(
              height: 50,
              width: 168,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isEnabled ? ColorConstants.primary : Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Upload Images",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        );
      },
    );
  }
}
