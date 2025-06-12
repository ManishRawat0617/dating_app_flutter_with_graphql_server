import 'package:dating_app/screens/sign_up/graphql/signup_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpInitialState()) {
    on<OnTextChangedEvent>(_onTextChanged);
    on<SignUpTappedEvent>(_onSignUpTappedEvent);
    on<TermsAndConditionsTappedEvent>(_onTermsAndConditionsTappedEvent);
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final bool isAgreed = false;

  void _onTextChanged(OnTextChangedEvent event, Emitter<SignUpState> emit) {
    final isEnabled = _checkIfSignUpButtonEnabled();
    emit(SignUpButtonEnabledChangedState(
      isEnabled: isEnabled,
    ));
  }

  bool _checkIfSignUpButtonEnabled() {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;
  }

  Future<void> _onSignUpTappedEvent(
      SignUpTappedEvent event, Emitter<SignUpState> emit) async {
    try {
      await SignupGraphql().registerUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      emit(const SignUpSuccessState());
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  void _onTermsAndConditionsTappedEvent(
      TermsAndConditionsTappedEvent event, Emitter<SignUpState> emit) {
    emit(TermsAndConditionsTappedState(isAgreed: event.isAgreed));
  }
}
