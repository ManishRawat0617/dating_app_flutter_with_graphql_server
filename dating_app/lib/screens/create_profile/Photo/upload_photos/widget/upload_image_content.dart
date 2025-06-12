import 'dart:io';
import 'package:dating_app/core/utilis/snackbar/ShowToast.dart';
import 'package:dating_app/screens/common_widget/loading_widget.dart';
import 'package:dating_app/screens/create_profile/Photo/upload_photos/bloc/upload_photo_bloc.dart';
import 'package:dating_app/screens/create_profile/Photo/upload_photos/bloc/upload_photo_event.dart';
import 'package:dating_app/screens/create_profile/Photo/upload_photos/bloc/upload_photo_state.dart';
import 'package:dating_app/screens/create_profile/Photo/upload_photos/widget/upload.dart';
import 'package:dating_app/screens/create_profile/bloc/personal_details_bloc.dart';
import 'package:dating_app/screens/create_profile/common_widget/dot_indicator.dart';
import 'package:dating_app/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';

// class UploadImageContent extends StatefulWidget {
//   const UploadImageContent({super.key});

//   @override
//   State<UploadImageContent> createState() => _UploadImageContentState();
// }

// class _UploadImageContentState extends State<UploadImageContent> {
//   final List<File> _selectedImages = [];

//   Future<void> _pickImage(ImageSource source) async {
//     final bloc = BlocProvider.of<UploadPhotoBloc>(context);
//     final ImagePicker picker = ImagePicker();
//     final XFile? pickedFile =
//         await picker.pickImage(source: source, imageQuality: 85);
//     if (pickedFile != null && _selectedImages.length < 3) {
//       // setState(() {
//       //   _selectedImages.add(File(pickedFile.path));
//       // });
//       bloc.add(AddPhotoEvent(file: File(pickedFile.path)));
//     }
//   }

//   void _showImageSourceActionSheet() {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => SafeArea(
//         child: Container(
//           height: 180,
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.camera_alt),
//                 title: const Text('Take a selfie'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _pickImage(ImageSource.camera);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text('Upload from gallery'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _pickImage(ImageSource.gallery);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: double.infinity,
//       width: double.infinity,
//       color: ColorConstants.white,
//       child: Stack(
//         children: [
//           _createMainBody(context),
//           BlocBuilder<UploadPhotoBloc, UploadPhotoState>(
//             buildWhen: (_, currState) =>
//                 currState is LoadingState || currState is ErrorState,
//             //  ||
//             // currState is NextTabBarPageState,
//             builder: (context, state) {
//               if (state is LoadingState) {
//                 return LoadingWidget();
//               }
//               return const SizedBox();
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _createMainBody(BuildContext context) {
//     final bloc = BlocProvider.of<UploadPhotoBloc>(context);
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const DotIndicatorWidget(
//               currentIndex: 4,
//               shouldSkip: false,
//             ),
//             const SizedBox(height: 30),
//             const TextWidget(
//               title: "Upload your images",
//               textSize: 24,
//               textColor: ColorConstants.primary,
//               boldness: FontWeight.bold,
//             ),
//             const SizedBox(height: 12),
//             const Text(
//               "The images will be shared in your profile.",
//               style: TextStyle(
//                 fontStyle: FontStyle.italic,
//                 fontSize: 14,
//                 color: Colors.grey,
//               ),
//             ),
//             const SizedBox(height: 24),
//             _buildImageGrid(),
//             const SizedBox(
//               height: 10,
//             ),
//             _buildUploadButton(context)
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStepIndicator() {
//     return Row(
//       children: List.generate(4, (index) {
//         return Container(
//           margin: const EdgeInsets.only(right: 8),
//           width: 10,
//           height: 10,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: index == 2 ? ColorConstants.primary : Colors.grey.shade300,
//           ),
//         );
//       }),
//     );
//   }

//   Widget _buildImageGrid() {
//     final bloc = BlocProvider.of<UploadPhotoBloc>(context);
//     dynamic _selectedImages = bloc.selectedImages;
//     List<Widget> gridItems = [];

//     // Add selected images with remove button
//     for (int index = 0; index < _selectedImages.length; index++) {
//       final image = _selectedImages[index];
//       gridItems.add(_buildSelectedPhoto(context, image, _selectedImages));
//     }

//     // Add add-image placeholder if less than 3
//     if (_selectedImages.length < 3) {
//       gridItems.add(
//         GestureDetector(
//           onTap: _showImageSourceActionSheet,
//           child: Container(
//             margin: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: const Center(
//               child: Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
//             ),
//           ),
//         ),
//       );
//     }

//     return BlocBuilder<UploadPhotoBloc, UploadPhotoState>(
//       buildWhen: (_, currState) => currState is PhotoSelectedState,
//       builder: (context, state) {
//         return GridView.count(
//           crossAxisCount: 2,
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           children: gridItems,
//         );
//       },
//     );
//   }

//   Widget _buildUploadButton(BuildContext context) {
//     final bloc = BlocProvider.of<UploadPhotoBloc>(context);
//     return BlocBuilder<UploadPhotoBloc, UploadPhotoState>(
//       buildWhen: (_, currState) => currState is UploadButtonEnabledChangedState,
//       builder: (context, state) {
//         bool isEnabled = false;
//         if (state is UploadButtonEnabledChangedState) {
//           isEnabled = state.isEnabled;
//           print(isEnabled);
//         }
//         return InkWell(
//           onTap: () async {
//             if (_selectedImages.isNotEmpty) {
//               // for (var img in _selectedImages) {
//               //   await uploadImageToServer(img);
//               // }
//             } else {
//               ShowToast.display(
//                 message: "Please select at least one image",
//               );
//             }
//           },
//           child: Container(
//             height: 50,
//             width: 160,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: isEnabled ? ColorConstants.primary : Colors.grey,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: const Text(
//               "Upload Images",
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSelectedPhoto(
//       BuildContext context, dynamic image, List<File> _selectedImages) {
//     return Stack(
//       children: [
//         Container(
//           margin: const EdgeInsets.all(8),
//           width: double.infinity,
//           height: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             image: DecorationImage(
//               image: FileImage(image),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         Positioned(
//           top: 4,
//           right: 4,
//           child: GestureDetector(
//             onTap: () {
//               setState(() {
//                 _selectedImages.remove(image);
//               });
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.6),
//                 shape: BoxShape.circle,
//               ),
//               padding: const EdgeInsets.all(4),
//               child: const Icon(
//                 Icons.close,
//                 color: Colors.white,
//                 size: 20,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

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

  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: Stack(
        children: [
          _createMainBody(context),
          BlocBuilder<UploadPhotoBloc, UploadPhotoState>(
            // buildWhen: (_, curr) => curr is LoadingState,
            builder: (_, state) {
              return
                  //  state is LoadingState ? LoadingWidget() :
                  const SizedBox();
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
            const DotIndicatorWidget(currentIndex: 4, shouldSkip: false),
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
    return BlocBuilder<UploadPhotoBloc, UploadPhotoState>(
      buildWhen: (_, curr) => curr is UploadButtonEnabledChangedState,
      builder: (context, state) {
        final isEnabled =
            state is UploadButtonEnabledChangedState && state.isEnabled;

        return InkWell(
          onTap: isEnabled
              ? () {
                  final selectedImages =
                      context.read<UploadPhotoBloc>().selectedImages;
                  if (selectedImages.isEmpty) {
                    ShowToast.display(
                        message: "Please select at least one image");
                  } else {
                    // Upload logic
                  }
                }
              : null,
          child: Container(
            height: 50,
            width: 160,
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
        );
      },
    );
  }
}
