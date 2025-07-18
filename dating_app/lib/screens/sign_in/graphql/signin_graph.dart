import 'dart:ffi';

import 'package:dating_app/core/service/graphql_service.dart';
import 'package:dating_app/core/service/shared_perference_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SignInGraphql {
  Future<Map<String, dynamic>> SignInUser(
      {required String email, required String password}) async {
    const String signInMutation = '''
mutation loginUser(\$email:String!, \$password_hash:String!) {
  loginUser(email: \$email, password_hash: \$password_hash) {
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
          MutationOptions(document: gql(signInMutation), variables: variables));

      if (response.data == null) {
        throw Exception('Sign in failed ');
      } else {
        final token = response.data?['loginUser']['token'];
        final userId = response.data?['loginUser']['user']['id'];
        SharedPrefsService.setAuthToken(token);
        SharedPrefsService.setUserID(userId);
        return {"token": token, "userId": userId};
      }
    } catch (e) {
      throw Exception('Server error: ${e.toString()}');
    }
  }
}
