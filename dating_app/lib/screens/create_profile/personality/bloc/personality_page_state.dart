part of 'personality_page_bloc.dart';

abstract class PersonalityPageState {}

class PersonalityPageInitialState extends PersonalityPageState {}

class PersonalityPageLoadingState extends PersonalityPageState {}

class PersonalityPageSuccessState extends PersonalityPageState {}

class PersonalityPageErrorState extends PersonalityPageState {
  final String message;
  PersonalityPageErrorState(this.message);
}

class UpdatePersonalityTypeState extends PersonalityPageState {
  final String? personalityType;
  UpdatePersonalityTypeState({required this.personalityType});
}

class UpdateZodiacSignState extends PersonalityPageState {
  final String? zodiacSign;
  UpdateZodiacSignState({required this.zodiacSign});
}

class UpdatePoliticalViewState extends PersonalityPageState {
  final String? politicalView;
  UpdatePoliticalViewState({required this.politicalView});
}

class UpdateLoveLanguageState extends PersonalityPageState {
  final String? loveLanguage;
  UpdateLoveLanguageState({required this.loveLanguage});
}

class UpdateHumorStyleState extends PersonalityPageState {
  final String? humorStyle;
  UpdateHumorStyleState({required this.humorStyle});
}

class NextPageEnabledChangedState extends PersonalityPageState {
  final bool isEnabled;
  NextPageEnabledChangedState({required this.isEnabled});
}
