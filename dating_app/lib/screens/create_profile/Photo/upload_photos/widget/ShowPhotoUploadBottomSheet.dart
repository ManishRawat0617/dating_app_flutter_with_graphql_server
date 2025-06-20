import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/text_constants.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart'; // Material Design Icons
import 'package:iconify_flutter/icons/ic.dart'; // Google Material Icons

Future<void> showPhotoUploadBottomSheet(
    BuildContext context, void Function(ImageSource) onImagePicked) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const TextWidget(
                      title: UploadPhotoPageText.title,
                      textSize: 20,
                      textColor: ColorConstants.primary,
                      boldness: FontWeight.bold,
                    ),
                    const SizedBox(height: 24),
                    ListTile(
                      leading: const Iconify(
                        Mdi.camera,
                        color: ColorConstants.primary,
                        size: 28,
                      ),
                      title: const TextWidget(
                        title: UploadPhotoPageText.takeASelfie,
                        textSize: 16,
                        boldness: FontWeight.w500,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        onImagePicked(ImageSource.camera);
                      },
                    ),
                    ListTile(
                      leading: const Iconify(
                        Ic.baseline_photo_library,
                        color: ColorConstants.primary,
                        size: 28,
                      ),
                      title: const TextWidget(
                        title: UploadPhotoPageText.uploadFromGallery,
                        textSize: 16,
                        boldness: FontWeight.w500,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        onImagePicked(ImageSource.gallery);
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
