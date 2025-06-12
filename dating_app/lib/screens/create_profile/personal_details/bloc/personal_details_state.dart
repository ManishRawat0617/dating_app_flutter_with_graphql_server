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

// error state
class ErrorState extends PersonalDetailsState {
  final String message;

  const ErrorState({required this.message});
}

// Loading state
class LoadingState extends PersonalDetailsState {
  const LoadingState();
}

// Success state
class SuccessState extends PersonalDetailsState {
  const SuccessState();
}

class NextPageQuickIntroductionState extends PersonalDetailsState {
  const NextPageQuickIntroductionState();
}

class NextPageUserPreferencesState extends PersonalDetailsState {
  const NextPageUserPreferencesState();
}

class NextPageMoreAboutYouState extends PersonalDetailsState {
  const NextPageMoreAboutYouState();
}

class NextPageVerifyPageState extends PersonalDetailsState {
  const NextPageVerifyPageState();
}

class NextPageUploadPhotoState extends PersonalDetailsState {
  const NextPageUploadPhotoState();
}
