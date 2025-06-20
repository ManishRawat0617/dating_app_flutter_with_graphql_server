import 'package:dating_app/core/service/shared_perference_service.dart';
import 'package:dating_app/screens/create_profile/lifestyle/graphql/clustering_api.dart';
import 'package:dating_app/screens/create_profile/lifestyle/graphql/lifestyle_page_graphhql.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'lifestyle_page_state.dart';
part 'lifestyle_page_event.dart';

class LifestylePageBloc extends Bloc<LifestylePageEvent, LifestylePageState> {
  LifestylePageBloc() : super(LifestylePageInitialState()) {
    on<LoadLifestyleData>(_onLoadLifestyleData);
    on<UpdateSmokingEvent>(_onUpdateSmoking);
    on<UpdateDrinkingEvent>(_onUpdateDrinking);
    on<UpdatePetsEvent>(_onUpdatePets);
    on<UpdateWantsKidsEvent>(_onUpdateWantsKids);
    on<UpdateDietaryPreferenceEvent>(_onUpdateDietaryPreference);
    on<UpdateRelationshipGoalEvent>(_onUpdateRelationshipGoal);
    on<UpdateFitnessLevelEvent>(_onUpdateFitnessLevel);
    on<UpdateReligionEvent>(_onUpdateReligion);
    on<UpdateSleepScheduleEvent>(_onUpdateSleepSchedule);
    on<SubmitLifestyleDetailsEvent>(_onSubmitLifestyleDetails);
  }

  bool? pets;
  bool? smoking;
  bool? drinking;
  bool? wantsKids;
  String? dietaryPreference;
  String? relationshipGoal;
  String? fitnessLevel;
  String? religion;
  String? sleepSchedule;

  bool isNextEnabled = false;

  Future<void> _onLoadLifestyleData(
    LoadLifestyleData event,
    Emitter<LifestylePageState> emit,
  ) async {
    emit(LifestylePageLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(LifestylePageSuccessState());
    } catch (_) {
      emit(LifestylePageErrorState('Failed to load lifestyle data.'));
    }
  }

  bool _checkIfNextPageButtonEnabled() {
    final bool enable = (smoking != null &&
        pets != null &&
        drinking != null &&
        wantsKids != null &&
        (dietaryPreference?.isNotEmpty ?? false) &&
        (relationshipGoal?.isNotEmpty ?? false) &&
        (religion?.isNotEmpty ?? false) &&
        (fitnessLevel?.isNotEmpty ?? false) &&
        (sleepSchedule?.isNotEmpty ?? false));

    return enable;
  }

  void _onUpdateSmoking(
    UpdateSmokingEvent event,
    Emitter<LifestylePageState> emit,
  ) {
    smoking = event.smoking;
    emit(UpdateSmokingState(smoking: smoking));
    emit(NextPageEnabledChangedState(
        isEnabled: _checkIfNextPageButtonEnabled()));
  }

  void _onUpdateDrinking(
    UpdateDrinkingEvent event,
    Emitter<LifestylePageState> emit,
  ) {
    drinking = event.drinking;
    emit(UpdateDrinkingState(drinking: drinking));
    emit(NextPageEnabledChangedState(
        isEnabled: _checkIfNextPageButtonEnabled()));
  }

  void _onUpdatePets(
    UpdatePetsEvent event,
    Emitter<LifestylePageState> emit,
  ) {
    pets = event.pets;
    emit(UpdatePetsState(pets: pets));
    emit(NextPageEnabledChangedState(
        isEnabled: _checkIfNextPageButtonEnabled()));
  }

  void _onUpdateWantsKids(
    UpdateWantsKidsEvent event,
    Emitter<LifestylePageState> emit,
  ) {
    wantsKids = event.wantsKids;
    emit(UpdateWantsKidsState(wantsKids: wantsKids));
    emit(NextPageEnabledChangedState(
        isEnabled: _checkIfNextPageButtonEnabled()));
  }

  void _onUpdateDietaryPreference(
    UpdateDietaryPreferenceEvent event,
    Emitter<LifestylePageState> emit,
  ) {
    dietaryPreference = event.dietaryPreference;
    emit(UpdateDietaryPreferenceState(dietaryPreference: dietaryPreference));
    emit(NextPageEnabledChangedState(
        isEnabled: _checkIfNextPageButtonEnabled()));
  }

  void _onUpdateRelationshipGoal(
    UpdateRelationshipGoalEvent event,
    Emitter<LifestylePageState> emit,
  ) {
    relationshipGoal = event.relationshipGoal;
    emit(UpdateRelationshipGoalState(relationshipGoal: relationshipGoal));
    emit(NextPageEnabledChangedState(
        isEnabled: _checkIfNextPageButtonEnabled()));
  }

  void _onUpdateFitnessLevel(
    UpdateFitnessLevelEvent event,
    Emitter<LifestylePageState> emit,
  ) {
    fitnessLevel = event.fitnessLevel;
    emit(UpdateFitnessLevelState(fitnessLevel: fitnessLevel));
    emit(NextPageEnabledChangedState(
        isEnabled: _checkIfNextPageButtonEnabled()));
  }

  void _onUpdateReligion(
    UpdateReligionEvent event,
    Emitter<LifestylePageState> emit,
  ) {
    religion = event.religion;
    emit(UpdateReligionState(religion: religion));
    emit(NextPageEnabledChangedState(
        isEnabled: _checkIfNextPageButtonEnabled()));
  }

  void _onUpdateSleepSchedule(
    UpdateSleepScheduleEvent event,
    Emitter<LifestylePageState> emit,
  ) {
    sleepSchedule = event.sleepSchedule;
    emit(UpdateSleepScheduleState(sleepSchedule: sleepSchedule));
    emit(NextPageEnabledChangedState(
        isEnabled: _checkIfNextPageButtonEnabled()));
  }

  Future<void> _onSubmitLifestyleDetails(
    SubmitLifestyleDetailsEvent event,
    Emitter<LifestylePageState> emit,
  ) async {
    emit(LifestylePageLoadingState());

    try {
      // await PythonAPI().sendLifestyleDataToClusteringAPI(
      //     userId: SharedPrefsService.getUserID().toString(),
      //     dietaryPreference: dietaryPreference ?? "",
      //     drinking: drinking ?? false,
      //     fitnessLevel: fitnessLevel ?? "",
      //     pets: pets ?? false,
      //     relationshipGoal: relationshipGoal ?? "",
      //     religion: religion ?? "",
      //     sleepSchedule: sleepSchedule ?? "",
      //     smoking: smoking ?? false,
      //     wantsKids: wantsKids ?? false);
      LifeStylePageGraphQL().addUserLifestyle(
          userId: SharedPrefsService.getUserID().toString(),
          dietaryPreference: dietaryPreference ?? "",
          drinking: drinking ?? false,
          fitnessLevel: fitnessLevel ?? "",
          pets: pets ?? false,
          relationshipGoal: relationshipGoal ?? "",
          religion: religion ?? "",
          sleepSchedule: sleepSchedule ?? "",
          smoking: smoking ?? false,
          wantsKids: wantsKids ?? false);
      emit(LifestylePageSuccessState());
    } catch (_) {
      emit(LifestylePageErrorState('Failed to submit lifestyle details.'));
    }
  }
}
