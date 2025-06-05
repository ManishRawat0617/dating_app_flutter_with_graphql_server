abstract class SignInState {
  const SignInState();
}

class SignInInitialState extends SignInState {
  const SignInInitialState();
}

class SignInButtonEnabledChangedState extends SignInState {
  final bool isEnabled;

  const SignInButtonEnabledChangedState({required this.isEnabled});
}

class ShowErrorState extends SignInState {
  const ShowErrorState();
}

class NextForgotPasswordPageState extends SignInState {
  const NextForgotPasswordPageState();
}

class NextSignupPageState extends SignInState {
  const NextSignupPageState();
}

class NextTabBarPageState extends SignInState {
  const NextTabBarPageState();
}

class ErrorState extends SignInState {
  final String message;

  const ErrorState({required this.message});
}

class LoadingState extends SignInState {
  const LoadingState();
}
