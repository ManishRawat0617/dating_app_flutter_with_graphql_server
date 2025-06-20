import 'package:dating_app/core/service/graphql_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LifeStylePageGraphQL {
  Future<bool> addUserLifestyle({
    required String userId,
    required String dietaryPreference,
    required bool drinking,
    required String fitnessLevel,
    required bool pets,
    required String relationshipGoal,
    required String religion,
    required String sleepSchedule,
    required bool smoking,
    required bool wantsKids,
  }) async {
    const String lifestyleMutation = '''
      mutation addLifestyle(
        \$user_id: ID!,
        \$dietary_preference: String!,
        \$drinking: Boolean!,
        \$fitness_level: String!,
        \$pets: Boolean!,
        \$relationship_goal: String!,
        \$religion: String!,
        \$sleep_schedule: String!,
        \$smoking: Boolean!,
        \$wants_kids: Boolean!
      ) {
        addLifestyle(
          user_id: \$user_id,
          dietary_preference: \$dietary_preference,
          drinking: \$drinking,
          fitness_level: \$fitness_level,
          pets: \$pets,
          relationship_goal: \$relationship_goal,
          religion: \$religion,
          sleep_schedule: \$sleep_schedule,
          smoking: \$smoking,
          wants_kids: \$wants_kids
        ) {
          user_id
        }
      }
    ''';

    final variables = {
      "user_id": userId,
      "dietary_preference": dietaryPreference,
      "drinking": drinking,
      "fitness_level": fitnessLevel,
      "pets": pets,
      "relationship_goal": relationshipGoal,
      "religion": religion,
      "sleep_schedule": sleepSchedule,
      "smoking": smoking,
      "wants_kids": wantsKids,
    };

    try {
      final response = await GraphQLService.client.mutate(
        MutationOptions(
          document: gql(lifestyleMutation),
          variables: variables,
        ),
      );

      if (response.hasException) {
        throw Exception(response.exception.toString());
      }

      final result = response.data?['addLifestyle'];
      if (result != null && result['user_id'] != null) {
        print(result);
        return true;
      } else {
        throw Exception('Failed to save lifestyle details');
      }
    } catch (e) {
      throw Exception('Server error: ${e.toString()}');
    }
  }
}
