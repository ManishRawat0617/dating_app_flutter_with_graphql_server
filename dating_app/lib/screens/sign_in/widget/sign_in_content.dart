import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/routes_name.dart';
import 'package:dating_app/core/constants/text_constants.dart';
import 'package:dating_app/core/utilis/validation/validationService.dart';
import 'package:dating_app/screens/common_widget/loading_widget.dart';
import 'package:dating_app/screens/common_widget/submit_button.dart';
import 'package:dating_app/screens/common_widget/textFormField.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:dating_app/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:dating_app/screens/sign_in/bloc/sign_in_event.dart';
import 'package:dating_app/screens/sign_in/bloc/sign_in_state.dart';
import 'package:dating_app/screens/sign_in/graphql/signin_graph.dart';
import 'package:dating_app/screens/sign_up/graphql/signup_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInContent extends StatefulWidget {
  const SignInContent({super.key});

  @override
  State<SignInContent> createState() => _SignInContentState();
}

class _SignInContentState extends State<SignInContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorConstants.white,
      child: Stack(
        children: [
          _createMainBody(context),
          BlocBuilder<SignInBloc, SignInState>(
            buildWhen: (_, currState) =>
                currState is LoadingState ||
                currState is ErrorState ||
                currState is NextTabBarPageState,
            builder: (context, state) {
              if (state is LoadingState) {
                return LoadingWidget();
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _createMainBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _createTitle(),
              const SizedBox(height: 20),
              _createForm(context),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to Forgot Password page
                },
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: TextWidget(
                    title: TextConstants.forgotPassword,
                    textSize: 14,
                    textAlign: TextAlign.right,
                    textColor: ColorConstants.primary,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              _createSubmitButton(context),
              const SizedBox(height: 20),
              _createDontHaveAccount(context), // 👈 added here!
            ],
          ),
        ),
      ),
    );
  }

  Widget _createTitle() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          title: TextConstants.signIn,
          boldness: FontWeight.bold,
          textSize: 30,
          textAlign: TextAlign.left,
          textColor: ColorConstants.primary,
        ),
      ],
    );
  }

  Widget _createForm(BuildContext context) {
    final bloc = BlocProvider.of<SignInBloc>(context);
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (_, currState) => currState is ShowErrorState,
      builder: (context, state) {
        return Column(
          children: [
            TextFieldWidget(
              title: TextConstants.email,
              placeholder: TextConstants.emailPlaceholder,
              errorText: TextConstants.emailErrorText,
              obscureText: false,
              isError: state is ShowErrorState
                  ? !ValidationService.email(bloc.emailController.text)
                  : false,
              controller: bloc.emailController,
              onTextChanged: () {
                bloc.add(const OnTextChangedEvent(email: '', password: ''));
              },
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            TextFieldWidget(
              title: TextConstants.password,
              placeholder: TextConstants.passwordPlaceholder,
              errorText: TextConstants.passwordErrorText,
              obscureText: true,
              isError: state is ShowErrorState
                  ? !ValidationService.password(bloc.passwordController.text)
                  : false,
              controller: bloc.passwordController,
              onTextChanged: () {
                bloc.add(const OnTextChangedEvent(email: '', password: ''));
              },
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
            ),
          ],
        );
      },
    );
  }

  Widget _createSubmitButton(BuildContext context) {
    final bloc = BlocProvider.of<SignInBloc>(context);
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (_, currState) => currState is SignInButtonEnabledChangedState,
      builder: (context, state) {
        bool isEnabled = false;
        if (state is SignInButtonEnabledChangedState) {
          isEnabled = state.isEnabled;
        }
        return SubmitButton(
          title: TextConstants.signIn,
          buttonColor: isEnabled ? ColorConstants.primary : ColorConstants.grey,
          ontap: () {
            bloc.add(const SignInTappedEvent());
          },
        );
      },
    );
  }

  Widget _createDontHaveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(fontSize: 16),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              RoutesName.signUp,
              (route) => false,
            );
            // SigninGraph().SignInUser(
            //     email: 'manishrawat1331@gmail.com', password: "password");
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 16,
              color: ColorConstants.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
