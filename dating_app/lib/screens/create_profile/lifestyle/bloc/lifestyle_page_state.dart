part of 'lifestyle_page_bloc.dart';

/// Base class for all lifestyle page states
abstract class LifestylePageState {}

/// Initial state when lifestyle page is first loaded
class LifestylePageInitialState extends LifestylePageState {}

/// State during data loading (e.g., API call)
class LifestylePageLoadingState extends LifestylePageState {}

/// State when lifestyle data is successfully loaded or submitted
class LifestylePageSuccessState extends LifestylePageState {}

/// State when an error occurs
class LifestylePageErrorState extends LifestylePageState {
  final String message;
  LifestylePageErrorState(this.message);
}

/// 🔽 Individual field update states — emitted when user updates specific field
class UpdateSmokingState extends LifestylePageState {
  final bool? smoking;
  UpdateSmokingState({required this.smoking});
}

class UpdateDrinkingState extends LifestylePageState {
  final bool? drinking;
  UpdateDrinkingState({required this.drinking});
}

class UpdatePetsState extends LifestylePageState {
  final bool? pets;
  UpdatePetsState({required this.pets});
}

class UpdateWantsKidsState extends LifestylePageState {
  final bool? wantsKids;
  UpdateWantsKidsState({required this.wantsKids});
}

class UpdateDietaryPreferenceState extends LifestylePageState {
  final String? dietaryPreference;
  UpdateDietaryPreferenceState({required this.dietaryPreference});
}

class UpdateRelationshipGoalState extends LifestylePageState {
  final String? relationshipGoal;
  UpdateRelationshipGoalState({required this.relationshipGoal});
}

class UpdateFitnessLevelState extends LifestylePageState {
  final String? fitnessLevel;
  UpdateFitnessLevelState({required this.fitnessLevel});
}

class UpdateReligionState extends LifestylePageState {
  final String? religion;
  UpdateReligionState({required this.religion});
}

class UpdateSleepScheduleState extends LifestylePageState {
  final String? sleepSchedule;
  UpdateSleepScheduleState({required this.sleepSchedule});
}

/// Triggered when the form validity is recalculated (e.g., enable/disable submit button)
class NextPageEnabledChangedState extends LifestylePageState {
  final bool isEnabled;
  NextPageEnabledChangedState({required this.isEnabled});
}
