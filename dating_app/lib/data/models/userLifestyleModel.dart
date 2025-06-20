class UserLifestyle {
  final bool smoking;
  final bool drinking;
  final bool pets;
  final bool wantsKids;
  final bool doesExercise;

  final String dietaryPreference;
  final String relationshipGoal;
  final String religion;
  final String sleepSchedule;
  final String exerciseFrequency;

  UserLifestyle({
    required this.smoking,
    required this.drinking,
    required this.pets,
    required this.wantsKids,
    required this.doesExercise,
    required this.dietaryPreference,
    required this.relationshipGoal,
    required this.religion,
    required this.sleepSchedule,
    required this.exerciseFrequency,
  });

  Map<String, dynamic> toMap() {
    return {
      'smoking': smoking,
      'drinking': drinking,
      'pets': pets,
      'wantsKids': wantsKids,
      'doesExercise': doesExercise,
      'dietaryPreference': dietaryPreference,
      'relationshipGoal': relationshipGoal,
      'religion': religion,
      'sleepSchedule': sleepSchedule,
      'exerciseFrequency': exerciseFrequency,
    };
  }

  factory UserLifestyle.fromMap(Map<String, dynamic> map) {
    return UserLifestyle(
      smoking: map['smoking'] ?? false,
      drinking: map['drinking'] ?? false,
      pets: map['pets'] ?? false,
      wantsKids: map['wantsKids'] ?? false,
      doesExercise: map['doesExercise'] ?? false,
      dietaryPreference: map['dietaryPreference'] ?? '',
      relationshipGoal: map['relationshipGoal'] ?? '',
      religion: map['religion'] ?? '',
      sleepSchedule: map['sleepSchedule'] ?? '',
      exerciseFrequency: map['exerciseFrequency'] ?? '',
    );
  }
}
