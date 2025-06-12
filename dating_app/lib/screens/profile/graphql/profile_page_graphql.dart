import 'package:dating_app/core/service/graphql_service.dart';
import 'package:dating_app/core/service/shared_perference_service.dart';
import 'package:dating_app/data/models/userModal.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<void> getUserProfile({required String user_id}) async {
  const String getUserProfileQuery = '''
  query getUserById(\$id: ID!) {
    getUserById(id:\$id) {
      id
      email
      age
      bio
      gender
      instagram_handle
      location
      name
      occupation
      created_at
      phone_number
    }
  }
  ''';

  final variables = {"id": user_id};

  final String? authToken = SharedPrefsService.getAuthToken();

  try {
    final response = await GraphQLService.client.query(
      QueryOptions(
        document: gql(getUserProfileQuery),
        variables: variables,
        context: Context.fromList([
          HttpLinkHeaders(headers: {
            'Authorization': 'Bearer $authToken',
          })
        ]),
      ),
    );

    print(response);
    if (response.hasException) {
      print("GraphQL Exception: ${response.exception.toString()}");
      throw new Exception("lsdfsd");
    } else {
      final userData = response.data?['getUserById'];

      UserModel user = UserModel(
        age: userData['age'].toString(),
        name: userData['name'].toString(),
        email: userData['email'].toString(),
        phone_number: userData['phone_number'].toString(),
        dateOfBirth: '2000-01-01',
        gender: userData['gender'].toString(),
        bio: userData['bio'].toString(),
        occupation: userData['occupation'].toString(),
        location: userData['location'].toString(),
        instagram: userData['instagram'].toString(),
      );

      await SharedPrefsService.saveUser(user);
    }
  } catch (e) {
    throw Exception('Server error: ${e.toString()}');
  }
}
