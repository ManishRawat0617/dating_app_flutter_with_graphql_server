import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:dating_app/screens/edit%20profile/page/edit_profile_page.dart';
import 'package:dating_app/screens/profile/bloc/profile_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/screens/profile/widget/profile_context.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilePageBloc(),
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<ProfilePageBloc, ProfilePageState>(
      listener: (context, state) {
        if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is EditDetailsState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditProfilePage()));
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const TextWidget(
                title: "Profile",
                textSize: 26,
                textAlign: TextAlign.right,
                textColor: ColorConstants.white,
                boldness: FontWeight.bold,
              ),
              centerTitle: true,
              backgroundColor: ColorConstants.primary,
              foregroundColor: Colors.black,
            ),
            body: ProfileContext());
      },
    );
  }
}
