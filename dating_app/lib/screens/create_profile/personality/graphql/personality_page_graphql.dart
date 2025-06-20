import 'package:dating_app/core/service/graphql_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PersonalityPageGraphQL {
  Future<void> addUserPersonality({
    required String userId,
    required String personalityType,
    required String zodiacSign,
    required String politicalView,
    required String loveLanguage,
    required String humorStyle,
  }) async {
    const String mutation = r'''
      mutation AddPersonality(
        $user_id: ID!,
        $personality_type: String!,
        $zodiac_sign: String!,
        $political_view: String!,
        $love_language: String!,
        $humor_style: String!
      ) {
        addPersonality(
          user_id: $user_id,
          personality_type: $personality_type,
          zodiac_sign: $zodiac_sign,
          political_view: $political_view,
          love_language: $love_language,
          humor_style: $humor_style
        ) {
          user_id
        }
      }
    ''';

    final variables = {
      "user_id": userId,
      "personality_type": personalityType,
      "zodiac_sign": zodiacSign,
      "political_view": politicalView,
      "love_language": loveLanguage,
      "humor_style": humorStyle,
    };

    final response = await GraphQLService.client
        .mutate(
          MutationOptions(
            document: gql(mutation),
            variables: variables,
          ),
        )
        .timeout(Duration(seconds: 5));

    if (response.hasException) {
      throw Exception("GraphQL Error: ${response.exception.toString()}");
    }
  }
}
