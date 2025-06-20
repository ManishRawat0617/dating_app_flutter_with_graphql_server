import 'dart:convert';

import 'package:dating_app/core/service/shared_perference_service.dart';
import 'package:dating_app/core/utilis/validation/validationService.dart';
import 'package:dating_app/screens/User/profile%20screen/graphql/profile_page_graphql.dart';
import 'package:dating_app/screens/sign_in/bloc/sign_in_event.dart';
import 'package:dating_app/screens/sign_in/bloc/sign_in_state.dart';
import 'package:dating_app/screens/sign_in/graphql/signin_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInInitialState()) {
    on<OnTextChangedEvent>(_onTextChanged);
    on<SignInTappedEvent>(_onSignInTappedEvent);
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final bool isAgreed = false;

  void _onTextChanged(OnTextChangedEvent event, Emitter<SignInState> emit) {
    final isEnabled = _checkIfSignInButtonEnabled();
    emit(SignInButtonEnabledChangedState(
      isEnabled: isEnabled,
    ));
  }

  bool _checkIfSignInButtonEnabled() {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  bool _validateTextFields() {
    return ValidationService.email(emailController.text) &&
        ValidationService.password(passwordController.text);
  }

  Future<void> _onSignInTappedEvent(
      SignInTappedEvent event, Emitter<SignInState> emit) async {
    if (_validateTextFields()) {
      try {
        // emit(const LoadingState());
        Map<String, dynamic> response = await SignInGraphql().SignInUser(
            email: emailController.value.text,
            password: passwordController.value.text);

        String auth_token = response['token'];

        if (response.isNotEmpty) {
          dynamic response = await getUserProfile(
              user_id: SharedPrefsService.getUserID().toString());
          SharedPrefsService.setAuthToken(auth_token);
          if (response.data['getUserById']['name'] == null) {
            emit(NextPersonalDetailPageState());
          } else {
            emit(const NextTabBarPageState());
          }
        } else {
          emit(ErrorState(message: "User not found !!"));
        }
      } catch (e) {
        emit(ErrorState(message: e.toString()));
      }
    } else {
      emit(const ShowErrorState());
    }
  }
}
