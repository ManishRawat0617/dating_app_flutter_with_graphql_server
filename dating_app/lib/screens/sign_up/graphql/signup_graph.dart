import 'package:dating_app/core/service/graphql_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SignupGraph {
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

  Future<void> updateUser({
    required String id,
    String? email,
    String? password_hash,
    String? gender,
    int? age,
    String? location,
    String? bio,
  }) async {
    const String updateUserMutation = '''
    mutation UpdateUser(
      \$id: ID!
      \$email: String
      \$password_hash: String
      \$gender: String
      \$age: Int
      \$location: String
      \$bio: String
    ) {
      updateUser(
        id: \$id
        email: \$email
        password_hash: \$password_hash
        gender: \$gender
        age: \$age
        location: \$location
        bio: \$bio
      ) {
        id
        email
        gender
        age
        location
        bio
      }
    }
  ''';

    final Map<String, dynamic> variables = {
      "id": id,
      if (email != null) "email": email,
      if (password_hash != null) "password_hash": password_hash,
      if (gender != null) "gender": gender,
      if (age != null) "age": age,
      if (location != null) "location": location,
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
}
