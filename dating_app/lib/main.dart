import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/service/shared_perference_service.dart';
import 'package:dating_app/screens/create_profile/more_about_you/page/more_about_you_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsService.init();
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.primary),
        scaffoldBackgroundColor: ColorConstants.background,
        useMaterial3: true,
      ),
      // initialRoute: RoutesName.signIn,
      // onGenerateRoute: Routes.generateRoute,
      home: MoreAboutYouPage(),
    );
  }
}
