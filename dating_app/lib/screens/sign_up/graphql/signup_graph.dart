import 'package:dating_app/core/service/graphql_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SignupGraphql {
  Future<Map<String, dynamic>> registerUser({
    required String email,
    required String password,
  }) async {
    const String registerMutation = '''
mutation registerUser(\$email: String!, \$password_hash: String!) {
  registerUser(email: \$email, password_hash: \$password_hash) {
    token
    user {
      id
    }
  }
}
''';

    final variables = {
      "email": email,
      "password_hash": password,
    };

    try {
      final response = await GraphQLService.client.mutate(
        MutationOptions(
          document: gql(registerMutation),
          variables: variables,
        ),
      );

      if (response.data == null || response.data!['registerUser'] == null) {
        throw Exception('Sign up failed');
      }

      return response.data!['registerUser'];
    } catch (e) {
      throw Exception('Server error: ${e.toString()}');
    }
  }

  Future<void> updateUser(
      {required String id,
      String? email,
      String? name,
      String? password_hash,
      String? gender,
      int? age,
      String? location,
      String? bio,
      String? occupation}) async {
    const String updateUserMutation = '''
    mutation UpdateUser(
      \$id: ID!
      \$email: String
      \$name: String
      \$password_hash: String
      \$gender: String
      \$age: Int
      \$location: String
      \$bio: String
      \$occupation:String
    ) {
      updateUser(
        id: \$id
        email: \$email
        name: \$name
        password_hash: \$password_hash
        gender: \$gender
        age: \$age
        location: \$location
        bio: \$bio
        occupation: \$occupation
      ) {
        id
        email
        gender
        age
        location
        bio
        name
      }
    }
  ''';

    final Map<String, dynamic> variables = {
      "id": id,
      if (email != null) "email": email,
      if (name != null) "name": name,
      if (password_hash != null) "password_hash": password_hash,
      if (gender != null) "gender": gender,
      if (age != null) "age": age,
      if (location != null) "location": location,
      if (occupation != null) "occupation": occupation,
      if (bio != null) "bio": bio,
    };

    try {
      final response = await GraphQLService.client.mutate(
        MutationOptions(
          document: gql(updateUserMutation),
          variables: variables,
        ),
      );

      if (response.hasException) {
        throw Exception('Update failed: ${response.exception.toString()}');
      } else {
        print('User updated successfully: ${response.data}');
      }
    } catch (e) {
      throw Exception('Server error: ${e.toString()}');
    }
  }

  Future<void> createUserPreference({
  required String userId,
  int? interestedAgeMin,
  int? interestedAgeMax,
  String? interestedGender,
  String? interestedReligion,
  int? maxDistance,
  String? typeOfRelationship,
}) async {
  const String mutation = r'''
    mutation CreateUserPreference($input: UserPreferenceInput!) {
      createUserPreference(input: $input) {
        id
        user_id
        interested_age_min
        interested_age_max
        interested_gender
        interested_religion
        max_distance
        type_of_relationship
      }
    }
  ''';

  final Map<String, dynamic> input = {
    "user_id": userId,
    if (interestedAgeMin != null) "interested_age_min": interestedAgeMin,
    if (interestedAgeMax != null) "interested_age_max": interestedAgeMax,
    if (interestedGender != null) "interested_gender": interestedGender,
    if (interestedReligion != null) "interested_religion": interestedReligion,
    if (maxDistance != null) "max_distance": maxDistance,
    if (typeOfRelationship != null) "type_of_relationship": typeOfRelationship,
  };

  try {
    final response = await GraphQLService.client.mutate(
      MutationOptions(
        document: gql(mutation),
        variables: {"input": input},
      ),
    );

    if (response.hasException) {
      throw Exception('CreateUserPreference failed: ${response.exception.toString()}');
    } else {
      print('User preference created: ${response.data}');
    }
  } catch (e) {
    throw Exception('Server error: ${e.toString()}');
  }
}

}
