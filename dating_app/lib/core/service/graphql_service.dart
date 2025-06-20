// import 'package:dating_app/core/constants/api_constants.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';

// class GraphQLService {
//   static final HttpLink httpLink = HttpLink(ApiEndpoints.graphqlServer);

//   static final GraphQLClient client = GraphQLClient(
//     link: httpLink,
//     cache: GraphQLCache(store: HiveStore()),
//   );
// }

import 'package:dating_app/core/service/shared_perference_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:dating_app/core/constants/api_constants.dart';

class GraphQLService {
  // Use your token storage method

  static final AuthLink authLink = AuthLink(
    getToken: () async {
      final token = await SharedPrefsService.getAuthToken();
      return token != null ? 'Bearer $token' : null;
    },
  );

  static final HttpLink httpLink = HttpLink(ApiEndpoints.graphqlServer);

  static final Link link = authLink.concat(httpLink);

  static final GraphQLClient client = GraphQLClient(
    link: link,
    cache: GraphQLCache(store: HiveStore()),
  );
}
