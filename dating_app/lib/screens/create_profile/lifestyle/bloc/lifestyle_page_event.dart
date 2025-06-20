part of 'lifestyle_page_bloc.dart';

abstract class LifestylePageEvent {}

// Triggered when the lifestyle page is first loaded
class LoadLifestyleData extends LifestylePageEvent {
  final String userId;

  LoadLifestyleData({required this.userId});
}

// Triggered when a field is updated individually
class UpdateSmokingEvent extends LifestylePageEvent {
  final bool smoking;

  UpdateSmokingEvent({required this.smoking});
}

class UpdateDrinkingEvent extends LifestylePageEvent {
  final bool drinking;

  UpdateDrinkingEvent({required this.drinking});
}

class UpdatePetsEvent extends LifestylePageEvent {
  final bool pets;

  UpdatePetsEvent({required this.pets});
}

class UpdateWantsKidsEvent extends LifestylePageEvent {
  final bool wantsKids;

  UpdateWantsKidsEvent({required this.wantsKids});
}

class UpdateDietaryPreferenceEvent extends LifestylePageEvent {
  final String dietaryPreference;

  UpdateDietaryPreferenceEvent({required this.dietaryPreference});
}

class UpdateRelationshipGoalEvent extends LifestylePageEvent {
  final String relationshipGoal;

  UpdateRelationshipGoalEvent({required this.relationshipGoal});
}

class UpdateFitnessLevelEvent extends LifestylePageEvent {
  final String fitnessLevel;

  UpdateFitnessLevelEvent({required this.fitnessLevel});
}

class UpdateReligionEvent extends LifestylePageEvent {
  final String religion;

  UpdateReligionEvent({required this.religion});
}

class UpdateSleepScheduleEvent extends LifestylePageEvent {
  final String sleepSchedule;

  UpdateSleepScheduleEvent({required this.sleepSchedule});
}

// Triggered when the user saves all changes
class SubmitLifestyleDetailsEvent extends LifestylePageEvent {
  final String userId;

  SubmitLifestyleDetailsEvent({required this.userId});
}
