import 'package:dating_app/core/constants/api_constants.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  static final HttpLink httpLink = HttpLink(ApiEndpoints.graphqlServer);

  static final GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: HiveStore()),
  );
}
