import 'package:dating_app/screens/create_profile/Photo/upload_photos/bloc/upload_photo_bloc.dart';
import 'package:dating_app/screens/create_profile/Photo/upload_photos/bloc/upload_photo_state.dart';
import 'package:dating_app/screens/create_profile/Photo/upload_photos/widget/upload_image_content.dart';
import 'package:dating_app/screens/create_profile/Photo/verify_user/page/verify_user_page.dart';
import 'package:dating_app/screens/create_profile/bloc/personal_details_bloc.dart';
import 'package:dating_app/screens/create_profile/create_profile_page.dart';
import 'package:dating_app/screens/create_profile/quick_introduction/widget/quick_introduction_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadImagePage extends StatelessWidget {
  const UploadImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UploadPhotoBloc(),
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<UploadPhotoBloc, UploadPhotoState>(
      listener: (context, state) {
        if (state is NextPageQuickIntroductionState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => QuickIntroductionContent()),
          );
        } else if (state is NextPageState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreateProfilePage()),
          );
        }
      },
      builder: (context, state) {
        return const Scaffold(
          body: UploadImageContent(), // Uses UploadPhotoBloc inside
        );
      },
    );
  }
}
