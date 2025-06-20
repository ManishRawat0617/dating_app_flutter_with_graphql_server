part of 'profile_page_bloc.dart';

abstract class ProfilePageState {
  const ProfilePageState();
}

class ProfilePageInitalState extends ProfilePageState {
  const ProfilePageInitalState();
}

class ShowErrorState extends ProfilePageState {
  const ShowErrorState();
}

class EditDetailsState extends ProfilePageState {
  const EditDetailsState();
}

class PhotoUploadState extends ProfilePageState {
  const PhotoUploadState();
}

class AppSettingsState extends ProfilePageState {
  const AppSettingsState();
}

class AskHelpDeskState extends ProfilePageState {
  const AskHelpDeskState();
}

class ErrorState extends ProfilePageState {
  final String message;

  const ErrorState({required this.message});
}

class LoadingState extends ProfilePageState {
  const LoadingState();
}
