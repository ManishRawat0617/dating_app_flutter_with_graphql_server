part of 'profile_page_bloc.dart';

abstract class ProfilePageEvent {
  const ProfilePageEvent();
}

class EditProfileTappedEvent extends ProfilePageEvent {
  const EditProfileTappedEvent();
}

class PhotoUploadTappedEvent extends ProfilePageEvent
{
  const PhotoUploadTappedEvent();

}

class AppSettingsTappedEvent extends ProfilePageEvent{
  const AppSettingsTappedEvent();

}

class AskHelpDeskTapped extends ProfilePageEvent{
  const AskHelpDeskTapped();
}

class LogOutTappedEvent extends ProfilePageEvent{
  const LogOutTappedEvent();
}