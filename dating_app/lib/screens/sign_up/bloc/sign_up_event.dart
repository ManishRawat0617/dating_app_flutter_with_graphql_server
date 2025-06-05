part of 'sign_up_bloc.dart';

abstract class SignUpEvent {
  const SignUpEvent();
}

// Triggered when user types in the email, password, or confirm password fields
class OnTextChangedEvent extends SignUpEvent {
  final String email;
  final String password;
  final String confirmPassword;

  const OnTextChangedEvent({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

// Triggered when the user taps the "Sign Up" button
class SignUpTappedEvent extends SignUpEvent {
  const SignUpTappedEvent();
}

// Triggered when the user taps the "Sign In" button instead
class SignInTappedEvent extends SignUpEvent {
  const SignInTappedEvent();
}

// Triggered when the user checks/unchecks the terms and conditions box
class TermsAndConditionsTappedEvent extends SignUpEvent {
  final bool isAgreed;

  const TermsAndConditionsTappedEvent({required this.isAgreed});
}
