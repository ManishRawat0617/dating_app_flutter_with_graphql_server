import 'package:dating_app/core/constants/routes_name.dart';
import 'package:dating_app/screens/sign_in/page/sign_in_page.dart';
import 'package:dating_app/screens/sign_up/page/sign_up_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.signIn:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignInPage());

      case RoutesName.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignUpPage());
      
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Column(
              children: [Text("No Route is found")],
            ),
          );
        });
    }
  }
}
