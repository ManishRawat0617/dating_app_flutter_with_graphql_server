

abstract class SignInEvent {
  const SignInEvent();
}

class OnTextChangedEvent extends SignInEvent {
  final String email;
  final String password;

  const OnTextChangedEvent({required this.email, required this.password});
}

class SignInTappedEvent extends SignInEvent {
  const SignInTappedEvent();
}

class SignUpTappedEvent extends SignInEvent {
  const SignUpTappedEvent();
}

class ForgotPasswordTappedEvent extends SignInEvent {
  const ForgotPasswordTappedEvent();
}
