import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/utilis/snackbar/status.dart';
import 'package:dating_app/screens/bottom_navigation/page/tab_bar.dart';
import 'package:dating_app/screens/sign_in/page/sign_in_page.dart';
import 'package:dating_app/screens/sign_up/bloc/sign_up_bloc.dart';
import 'package:dating_app/screens/sign_up/widget/sign_up_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// Replace with actual SignInPage import

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: Scaffold(body: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is NextSignInPageState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => const SignInPage()), // <-- Fix here
          );
        } else if (state is SignUpSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => SignInPage()), // <-- Replace with actual widget
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(StatusSnackbar.show(
                title: "Success",
                message: "User register successfully",
                contentType: ContentType.success));
        } else if (state is ErrorState) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(StatusSnackbar.show(
              title: 'Error',
              message: state.message,
              contentType: ContentType.failure,
            ));
        }
      },
      builder: (context, state) {
        return const SignUpContent();
      },
    );
  }
}
