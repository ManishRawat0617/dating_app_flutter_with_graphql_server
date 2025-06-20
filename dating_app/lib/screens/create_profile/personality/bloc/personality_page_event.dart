part of 'personality_page_bloc.dart';

abstract class PersonalityPageEvent {}

class LoadPersonalityData extends PersonalityPageEvent {}

class UpdatePersonalityTypeEvent extends PersonalityPageEvent {
  final String personalityType;
  UpdatePersonalityTypeEvent({required this.personalityType});
}

class UpdateZodiacSignEvent extends PersonalityPageEvent {
  final String zodiacSign;
  UpdateZodiacSignEvent({required this.zodiacSign});
}

class UpdatePoliticalViewEvent extends PersonalityPageEvent {
  final String politicalView;
  UpdatePoliticalViewEvent({required this.politicalView});
}

class UpdateLoveLanguageEvent extends PersonalityPageEvent {
  final String loveLanguage;
  UpdateLoveLanguageEvent({required this.loveLanguage});
}

class UpdateHumorStyleEvent extends PersonalityPageEvent {
  final String humorStyle;
  UpdateHumorStyleEvent({required this.humorStyle});
}

class SubmitPersonalityDetailsEvent extends PersonalityPageEvent {}
