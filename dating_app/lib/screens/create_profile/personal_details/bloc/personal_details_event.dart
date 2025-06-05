part of 'personal_details_bloc.dart';

@immutable
abstract class PersonalDetailsEvent {
  const PersonalDetailsEvent();
}

// Personal details event for text changes
class OnTextChangedPersonalDetails extends PersonalDetailsEvent {
  final String firstName;
  final String lastName;
  final String age;
  final String dateOfBirth;
  final String gender;
  final String sexualOrientation;

  const OnTextChangedPersonalDetails({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.dateOfBirth,
    required this.gender,
    required this.sexualOrientation,
  });
}

// Quick introduction event for bio text changes
class OnTextChangedQuickIntroduction extends PersonalDetailsEvent {
  final String bio;

  const OnTextChangedQuickIntroduction({required this.bio});
}

// Quick introduction event for bio text changes
class OnTextChangedUserPreference extends PersonalDetailsEvent {
  final String typeOfRelationshipInterestedIn;
  final String interestedGenderIn;
  final String interestedReligionIn;
  final String interestedInAgeRange;
  final String interestedInDistance;

  const OnTextChangedUserPreference({
    required this.typeOfRelationshipInterestedIn,
    required this.interestedGenderIn,
    required this.interestedReligionIn,
    required this.interestedInAgeRange,
    required this.interestedInDistance,
  });
}

// Event for tapping next page button
class NextPageQuickIntroductionTapped extends PersonalDetailsEvent {
  const NextPageQuickIntroductionTapped();
}

class NextPageUserPreferencesTapped extends PersonalDetailsEvent {
  const NextPageUserPreferencesTapped();
}

class NextPageMoreAboutYouTapped extends PersonalDetailsEvent {
  const NextPageMoreAboutYouTapped();
}

class NextPageUploadPhotoTapped extends PersonalDetailsEvent {
  const NextPageUploadPhotoTapped();
}

class NextPageVerifyUserTapped extends PersonalDetailsEvent {
  const NextPageVerifyUserTapped();
}
