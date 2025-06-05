import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/routes_name.dart';
import 'package:dating_app/core/constants/text_constants.dart';
import 'package:dating_app/core/utilis/validation/validationService.dart';
import 'package:dating_app/screens/common_widget/loading_widget.dart';
import 'package:dating_app/screens/common_widget/submit_button.dart';
import 'package:dating_app/screens/common_widget/textFormField.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:dating_app/screens/sign_up/bloc/sign_up_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpContent extends StatefulWidget {
  const SignUpContent({super.key});

  @override
  State<SignUpContent> createState() => _SignUpContentState();
}

class _SignUpContentState extends State<SignUpContent> {
  bool _agreed = false;

  void _showTerms() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Terms and Conditions"),
        content: const Text("Here are your app's terms and conditions..."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            _createMainBody(context),
            BlocBuilder<SignUpBloc, SignUpState>(
              buildWhen: (prev, curr) =>
                  curr is LoadingState ||
                  curr is ErrorState ||
                  curr is NextTabBarPageState,
              builder: (context, state) {
                if (state is LoadingState) {
                  return LoadingWidget();
                }
                return const SizedBox();
              },
            )
          ],
        ));
  }

  Widget _createMainBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _createTitle(),
            const SizedBox(height: 20),
            _createForm(context),
            const SizedBox(height: 10),
            _createTermsAndConditions(context),
            const SizedBox(height: 40),
            _createSubmitButton(context),
            const SizedBox(height: 20),
            _createAlreadyHaveAccount(context),
          ],
        ),
      ),
    );
  }

  Widget _createTitle() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          title: TextConstants.signUp,
          boldness: FontWeight.bold,
          textSize: 30,
          textAlign: TextAlign.left,
          textColor: ColorConstants.primary,
        ),
        SizedBox(height: 10),
        TextWidget(
          title: TextConstants.requiredField,
          textColor: Colors.grey,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  Widget _createForm(BuildContext content) {
    final bloc = BlocProvider.of<SignUpBloc>(context);
    return BlocBuilder<SignUpBloc, SignUpState>(
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
                bloc.add(const OnTextChangedEvent(
                    email: "", password: "", confirmPassword: ""));
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
              isError: false,
              controller: bloc.passwordController,
              onTextChanged: () {
                bloc.add(const OnTextChangedEvent(
                    email: "", password: "", confirmPassword: ""));
              },
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            const TextWidget(
              title: TextConstants.passwordErrorText2,
              textSize: 12,
              textAlign: TextAlign.start,
              textColor: Colors.grey,
            ),
            const SizedBox(height: 10),
            TextFieldWidget(
              title: TextConstants.confirmPassword,
              placeholder: TextConstants.confirmPasswordPlaceholder,
              errorText: TextConstants.confirmPasswordErrorText,
              obscureText: true,
              isError: false,
              controller: bloc.confirmPasswordController,
              onTextChanged: () {
                bloc.add(const OnTextChangedEvent(
                    email: "", password: "", confirmPassword: ""));
              },
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        );
      },
    );
  }

  Widget _createTermsAndConditions(BuildContext content) {
    final bloc = BlocProvider.of<SignUpBloc>(context);
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        bool isAgreed = false;
        if (state is TermsAndConditionsTappedState) {
          isAgreed = state.isAgreed;
        }
        return CheckboxListTile(
          activeColor: ColorConstants.primary,
          value: isAgreed,
          onChanged: (bool? value) {
            bloc.add(TermsAndConditionsTappedEvent(isAgreed: value ?? false));
          },
          title: Text.rich(
            TextSpan(
              text: "I agree to the ",
              style: const TextStyle(color: Colors.grey),
              children: [
                TextSpan(
                  text: "Terms and Conditions",
                  style: const TextStyle(
                    color: ColorConstants.primary,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = _showTerms,
                ),
              ],
            ),
          ),
          controlAffinity: ListTileControlAffinity.leading,
        );
      },
    );
  }

  Widget _createSubmitButton(BuildContext context) {
    final bloc = BlocProvider.of<SignUpBloc>(context);
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (_, currState) => currState is SignUpButtonEnabledChangedState,
      builder: (context, state) {
        bool isEnabled = false;
        if (state is SignUpButtonEnabledChangedState) {
          isEnabled = state.isEnabled;
        }
        return SubmitButton(
          title: TextConstants.signIn,
          buttonColor: isEnabled ? ColorConstants.primary : ColorConstants.grey,
          ontap: () {
            bloc.add(const SignUpTappedEvent());
          },
        );
      },
    );
  }

  Widget _createAlreadyHaveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account? ",
          style: TextStyle(fontSize: 16),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              RoutesName.signIn,
              (route) => false,
            ); // 👈 use your route
          },
          child: const Text(
            "Sign In",
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
