import 'package:dating_app/core/service/graphql_service.dart';
import 'package:dating_app/core/service/shared_perference_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<List<Map<String, dynamic>>> getLikesToUser(
    {required String userId}) async {
  const String query = r'''
    query GetLikesToUser($userId: ID!) {
      getLikesToUser(userId: $userId) {
         from_user_id
    liked_at
    liker_age
    liker_name
    profile_photo_url
      }
    }
  ''';

  try {
    final response = await GraphQLService.client.query(
      QueryOptions(
        document: gql(query),
        variables: {"userId": userId},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (response.hasException) {
      throw Exception(
          'getLikesToUser failed: ${response.exception.toString()}');
    }

    final data = response.data?['getLikesToUser'] as List<dynamic>;

    return data.map((item) => item as Map<String, dynamic>).toList();
  } catch (e) {
    throw Exception('Server error: ${e.toString()}');
  }
}
