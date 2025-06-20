import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_page_state.dart';
part 'profile_page_event.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  ProfilePageBloc() : super(const ProfilePageInitalState()) {
    on<EditProfileTappedEvent>(_onEditProfileTappedEvent);
    on<PhotoUploadTappedEvent>(_onPhotoUploadTappedEvent);
    on<AppSettingsTappedEvent>(_onAppSettingsTappedEvent);
    on<AskHelpDeskTapped>(_onAskHelpDeskTapped);
    on<LogOutTappedEvent>(_onLogOutTappedEvent);
  }

  Future<void> _onEditProfileTappedEvent(
      EditProfileTappedEvent event, Emitter<ProfilePageState> emit) async {
    emit(const EditDetailsState());
  }

  FutureOr<void> _onPhotoUploadTappedEvent(
      PhotoUploadTappedEvent event, Emitter<ProfilePageState> emit) {}

  FutureOr<void> _onAppSettingsTappedEvent(
      AppSettingsTappedEvent event, Emitter<ProfilePageState> emit) {}

  FutureOr<void> _onAskHelpDeskTapped(
      AskHelpDeskTapped event, Emitter<ProfilePageState> emit) {}

  FutureOr<void> _onLogOutTappedEvent(
      LogOutTappedEvent event, Emitter<ProfilePageState> emit) {
    print("log out");
  }
}
