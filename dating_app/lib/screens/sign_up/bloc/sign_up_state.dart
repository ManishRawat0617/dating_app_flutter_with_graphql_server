part of 'sign_up_bloc.dart';

abstract class SignUpState {
  const SignUpState();
}

// Use PascalCase for class names
class SignUpInitialState extends SignUpState {
  const SignUpInitialState();
}

class SignUpButtonEnabledChangedState extends SignUpState {
  final bool isEnabled;
  const SignUpButtonEnabledChangedState({required this.isEnabled});
}

class ShowErrorState extends SignUpState {
  const ShowErrorState();
}

class NextSignInPageState extends SignUpState {
  const NextSignInPageState();
}

class NextTabBarPageState extends SignUpState {
  const NextTabBarPageState();
}

class ErrorState extends SignUpState {
  final String message;

  const ErrorState({required this.message});
}

class LoadingState extends SignUpState {
  const LoadingState();
}

class TermsAndConditionsTappedState extends SignUpState {
  final bool isAgreed;

  const TermsAndConditionsTappedState({required this.isAgreed});
}

class SignUpSuccessState extends SignUpState {
  const SignUpSuccessState();
}
