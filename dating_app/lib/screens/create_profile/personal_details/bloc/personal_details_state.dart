part of 'personal_details_bloc.dart';

abstract class PersonalDetailsState {
  const PersonalDetailsState();
}

class CreateProfileInitialState extends PersonalDetailsState {
  const CreateProfileInitialState();
}

class NextPageEnabledChangedState extends PersonalDetailsState {
  final bool isEnabled;
  const NextPageEnabledChangedState({required this.isEnabled});
}

class ShowErrorState extends PersonalDetailsState {
  const ShowErrorState();
}

class NextPageQuickIntroductionState extends PersonalDetailsState {
  const NextPageQuickIntroductionState();
}

class NextPageUserPreferencesState extends PersonalDetailsState {
  const NextPageUserPreferencesState();
}


class ErrorState extends PersonalDetailsState {
  final String message;

  const ErrorState({required this.message});
}

class LoadingState extends PersonalDetailsState {
  const LoadingState();
}

class SuccessState extends PersonalDetailsState {
  const SuccessState();
}
