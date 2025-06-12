import 'package:dating_app/core/service/shared_perference_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'personal_details_state.dart';
part 'personal_details_event.dart';

class PersonalDetailsBloc
    extends Bloc<PersonalDetailsEvent, PersonalDetailsState> {
  PersonalDetailsBloc() : super(const CreateProfileInitialState()) {
    on<OnTextChangedPersonalDetails>(_onTextChangedPersonalDetails);
    on<OnTextChangedQuickIntroduction>(_onTextChangedQuickIntroduction);
    on<OnTextChangedUserPreference>(_onTextChangedUserPreference);
    on<OnTextChangedMoreAboutYou>(_onTextChangedMoreAboutYou);
    on<AgeRangeChanged>(_onAgeRangeChanged);
    on<DistanceChanged>(_onDistanceChanged);
    on<NextPageQuickIntroductionTapped>(_onNextPageQuickIntroductionTapped);
    on<NextPageUserPreferencesTapped>(_onNextPageUserPreferencesTapped);
    on<NextPageMoreAboutYouTapped>(_onNextPageMoreAboutYouTapped);
    on<NextPageVerifyUserTapped>(_onNextPageVerifyUserTapped);
    on<NextPageUploadPhotoTapped>(_onNextPageUploadPhotoTapped);
  }
// dot indicator index
  final int currentIndex = 0;

// personal details controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final sexualOrientationController = TextEditingController();
  final genderController = TextEditingController();

// bio controller
  final bioController = TextEditingController();

  // user preferences controllers
  String? typeOfRelationshipInterestedInController;
  final interestedInController = TextEditingController();
  String? interestedGenderInController;
  String? interestedReligionInController;
  RangeValues interestedInAgeRangeController = RangeValues(18, 60);
  double? interestedInDistanceController;

  // more about you controllers
  final occupationController = TextEditingController();
  final locationController = TextEditingController();
  final instagramController = TextEditingController();

  bool _checkIfNextPageQuickIntroductionButtonEnabled() {
    return firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        dateOfBirthController.text.isNotEmpty;
  }

  void _onTextChangedPersonalDetails(
    OnTextChangedPersonalDetails event,
    Emitter<PersonalDetailsState> emit,
  ) {
    final isEnabled = _checkIfNextPageQuickIntroductionButtonEnabled();
    emit(NextPageEnabledChangedState(isEnabled: isEnabled));
  }

  void _onTextChangedQuickIntroduction(
    OnTextChangedQuickIntroduction event,
    Emitter<PersonalDetailsState> emit,
  ) {
    final isEnabled = bioController.text.isNotEmpty;
    emit(NextPageEnabledChangedState(isEnabled: isEnabled));
  }

  void _onTextChangedMoreAboutYou(
    OnTextChangedMoreAboutYou event,
    Emitter<PersonalDetailsState> emit,
  ) {
    final isEnabled = occupationController.text.isNotEmpty &&
        locationController.text.isNotEmpty;
    emit(NextPageEnabledChangedState(isEnabled: isEnabled));
  }

  void _onTextChangedUserPreference(
    OnTextChangedUserPreference event,
    Emitter<PersonalDetailsState> emit,
  ) {
    final isEnabled = typeOfRelationshipInterestedInController!.isNotEmpty &&
        interestedGenderInController!.isNotEmpty &&
        interestedReligionInController!.isNotEmpty;

    emit(NextPageEnabledChangedState(isEnabled: isEnabled));
  }

  void _onAgeRangeChanged(
      AgeRangeChanged event, Emitter<PersonalDetailsState> emit) {
    interestedInAgeRangeController = event.ageRange;

    emit(AgeRangeUpdatedState(ageRange: event.ageRange));
  }

  void _onDistanceChanged(
      DistanceChanged event, Emitter<PersonalDetailsState> emit) {
    interestedInDistanceController = event.distance;

    emit(DistanceUpdateState(distance: event.distance));
  }

  Future<void> _onNextPageQuickIntroductionTapped(
    NextPageQuickIntroductionTapped event,
    Emitter<PersonalDetailsState> emit,
  ) async {
    try {
      await SharedPrefsService.setOccupation(occupationController.text);
      await SharedPrefsService.setLocation(locationController.text);
      await SharedPrefsService.setInstagram(instagramController.text);
      emit(const LoadingState());
      emit(const NextPageQuickIntroductionState());
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> _onNextPageUserPreferencesTapped(
    NextPageUserPreferencesTapped event,
    Emitter<PersonalDetailsState> emit,
  ) async {
    try {
      await SharedPrefsService.setBio(bioController.text);

      emit(const LoadingState());
      emit(const NextPageUserPreferencesState());
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> _onNextPageUploadPhotoTapped(
    NextPageUploadPhotoTapped event,
    Emitter<PersonalDetailsState> emit,
  ) async {
    try {
      await SharedPrefsService.setRelationshipType(
          typeOfRelationshipInterestedInController.toString());
      await SharedPrefsService.setAgeRange(interestedInAgeRangeController.start,
          interestedInAgeRangeController.end);
      await SharedPrefsService.setDistance(
          interestedInDistanceController!.toDouble());
      await SharedPrefsService.setGenderInterestedIn(
          interestedGenderInController.toString());
      await SharedPrefsService.setReligionInterestedIn(
          interestedReligionInController.toString());

      emit(const LoadingState());
      emit(const NextPageUploadPhotoState());
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> _onNextPageMoreAboutYouTapped(
    NextPageMoreAboutYouTapped event,
    Emitter<PersonalDetailsState> emit,
  ) async {
    try {
      await SharedPrefsService.setFirstName(firstNameController.text);
      await SharedPrefsService.setLastName(lastNameController.text);
      await SharedPrefsService.setAge(ageController.text);
      await SharedPrefsService.setDateOfBirth(dateOfBirthController.text);
      await SharedPrefsService.setGender(genderController.text);
      emit(const LoadingState());
      emit(const NextPageMoreAboutYouState());
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> _onNextPageVerifyUserTapped(
    NextPageVerifyUserTapped event,
    Emitter<PersonalDetailsState> emit,
  ) async {
    try {
      emit(const LoadingState());
      emit(const NextPageUserPreferencesState());
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    dateOfBirthController.dispose();
    sexualOrientationController.dispose();
    bioController.dispose();
    return super.close();
  }
}
