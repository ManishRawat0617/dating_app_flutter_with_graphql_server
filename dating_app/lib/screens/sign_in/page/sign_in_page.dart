import 'package:dating_app/core/utilis/snackbar/ShowToast.dart';
import 'package:dating_app/screens/bottom_navigation/page/tab_bar.dart';
import 'package:dating_app/screens/create_profile/personal_details/page/Personal_details_page.dart';
import 'package:dating_app/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:dating_app/screens/sign_in/bloc/sign_in_state.dart';
import 'package:dating_app/screens/sign_in/widget/sign_in_content.dart';

import 'package:dating_app/screens/sign_up/page/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInBloc(),
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is NextForgotPasswordPageState) {
        } else if (state is NextSignupPageState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SignUpPage()),
          );
        } else if (state is NextPersonalDetailPageState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => PersonalDetailsPage()),
          );
        } else if (state is NextTabBarPageState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => BottomNavBar()),
          );
        } else if (state is ErrorState) {
          ShowToast.display(message: state.message);
        }
      },
      builder: (context, state) {
        return const SignInContent();
      },
    );
  }
}
