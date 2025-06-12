import 'package:dating_app/screens/create_profile/bloc/personal_details_bloc.dart';
import 'package:dating_app/screens/create_profile/personal_details/widget/personal_details_content.dart';
import 'package:dating_app/screens/create_profile/quick_introduction/widget/quick_introduction_content.dart';
import 'package:dating_app/screens/create_profile/Photo/upload_photos/page/upload_image_page.dart';
import 'package:dating_app/screens/create_profile/user_preference/widget/user_preference_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPreferencePage extends StatelessWidget {
  UserPreferencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PersonalDetailsBloc(), child: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<PersonalDetailsBloc, PersonalDetailsState>(
      listener: (context, state) {
        if (state is NextPageUploadPhotoState) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => UploadImagePage()),
            );
          });
        } else if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: UserPreferencesContent(), // assuming this uses the bloc
        );
      },
    );
  }
}
