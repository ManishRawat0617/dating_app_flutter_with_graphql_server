import 'dart:async';

import 'package:dating_app/core/service/shared_perference_service.dart';
import 'package:dating_app/screens/create_profile/personality/graphql/personality_page_graphql.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'personality_page_event.dart';
part 'personality_page_state.dart';

class PersonalityPageBloc
    extends Bloc<PersonalityPageEvent, PersonalityPageState> {
  PersonalityPageBloc() : super(PersonalityPageInitialState()) {
    on<LoadPersonalityData>(_onLoadPersonalityData);
    on<UpdatePersonalityTypeEvent>(_onUpdatePersonalityType);
    on<UpdateZodiacSignEvent>(_onUpdateZodiacSign);
    on<UpdatePoliticalViewEvent>(_onUpdatePoliticalView);
    on<UpdateLoveLanguageEvent>(_onUpdateLoveLanguage);
    on<UpdateHumorStyleEvent>(_onUpdateHumorStyle);
    on<SubmitPersonalityDetailsEvent>(_onSubmitPersonalityDetails);
  }

  String? personalityType;
  String? zodiacSign;
  String? politicalView;
  String? loveLanguage;
  String? humorStyle;

  bool isNextEnabled = false;

  bool _checkIfNextEnabled() {
    return (personalityType?.isNotEmpty ?? false) &&
        (zodiacSign?.isNotEmpty ?? false) &&
        (politicalView?.isNotEmpty ?? false) &&
        (loveLanguage?.isNotEmpty ?? false) &&
        (humorStyle?.isNotEmpty ?? false);
  }

  void _onUpdatePersonalityType(
    UpdatePersonalityTypeEvent event,
    Emitter<PersonalityPageState> emit,
  ) {
    personalityType = event.personalityType;
    emit(UpdatePersonalityTypeState(personalityType: personalityType));
    emit(NextPageEnabledChangedState(isEnabled: _checkIfNextEnabled()));
  }

  void _onUpdateZodiacSign(
    UpdateZodiacSignEvent event,
    Emitter<PersonalityPageState> emit,
  ) {
    zodiacSign = event.zodiacSign;
    emit(UpdateZodiacSignState(zodiacSign: zodiacSign));
    emit(NextPageEnabledChangedState(isEnabled: _checkIfNextEnabled()));
  }

  void _onUpdatePoliticalView(
    UpdatePoliticalViewEvent event,
    Emitter<PersonalityPageState> emit,
  ) {
    politicalView = event.politicalView;
    emit(UpdatePoliticalViewState(politicalView: politicalView));
    emit(NextPageEnabledChangedState(isEnabled: _checkIfNextEnabled()));
  }

  void _onUpdateLoveLanguage(
    UpdateLoveLanguageEvent event,
    Emitter<PersonalityPageState> emit,
  ) {
    loveLanguage = event.loveLanguage;
    emit(UpdateLoveLanguageState(loveLanguage: loveLanguage));
    emit(NextPageEnabledChangedState(isEnabled: _checkIfNextEnabled()));
  }

  void _onUpdateHumorStyle(
    UpdateHumorStyleEvent event,
    Emitter<PersonalityPageState> emit,
  ) {
    humorStyle = event.humorStyle;
    emit(UpdateHumorStyleState(humorStyle: humorStyle));
    emit(NextPageEnabledChangedState(isEnabled: _checkIfNextEnabled()));
  }

  Future<void> _onLoadPersonalityData(
    LoadPersonalityData event,
    Emitter<PersonalityPageState> emit,
  ) async {
    emit(PersonalityPageLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(PersonalityPageSuccessState());
    } catch (e) {
      emit(PersonalityPageErrorState('Failed to load personality data.'));
    }
  }

  Future<void> _onSubmitPersonalityDetails(
    SubmitPersonalityDetailsEvent event,
    Emitter<PersonalityPageState> emit,
  ) async {
    emit(PersonalityPageLoadingState());
    try {
      await PersonalityPageGraphQL().addUserPersonality(
        userId: SharedPrefsService.getUserID().toString(),
        personalityType: personalityType ?? '',
        zodiacSign: zodiacSign ?? '',
        politicalView: politicalView ?? '',
        loveLanguage: loveLanguage ?? '',
        humorStyle: humorStyle ?? '',
      );
      emit(PersonalityPageSuccessState());
    } on TimeoutException {
      emit(PersonalityPageErrorState(
          'Failed to submit personality details due to timeout.'));
    } catch (e) {
      emit(PersonalityPageErrorState('Failed to submit personality details.'));
    }
  }
}
