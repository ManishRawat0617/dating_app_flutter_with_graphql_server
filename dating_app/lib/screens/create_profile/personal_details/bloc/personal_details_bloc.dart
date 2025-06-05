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
    on<NextPageQuickIntroductionTapped>(_onNextPageQuickIntroductionTapped);
    on<NextPageUserPreferencesTapped>(_onNextPageUserPreferencesTapped);
    
  }

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
  final typeOfRelationshipInterestedInController = TextEditingController();
  final interestedInController = TextEditingController();
  final interestedGenderInController = TextEditingController();
  final interestedReligionInController = TextEditingController();
  final interestedInAgeRangeController = TextEditingController();
  final interestedInDistanceController = TextEditingController();

  bool _checkIfNextPageQuickIntroductionButtonEnabled() {
    return firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        dateOfBirthController.text.isNotEmpty &&
        sexualOrientationController.text.isNotEmpty;
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

  void _onTextChangedUserPreference(
    OnTextChangedUserPreference event,
    Emitter<PersonalDetailsState> emit,
  ) {
    final isEnabled = bioController.text.isNotEmpty;
    emit(NextPageEnabledChangedState(isEnabled: isEnabled));
  }

  Future<void> _onNextPageQuickIntroductionTapped(
    NextPageQuickIntroductionTapped event,
    Emitter<PersonalDetailsState> emit,
  ) async {
    try {
      await SharedPrefsService.setFirstName(firstNameController.text);
      await SharedPrefsService.setLastName(lastNameController.text);
      await SharedPrefsService.setAge(ageController.text);
      await SharedPrefsService.setDateOfBirth(dateOfBirthController.text);
      await SharedPrefsService.setGender(genderController.text);
      await SharedPrefsService.setSexualOrientation(
          sexualOrientationController.text);

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
