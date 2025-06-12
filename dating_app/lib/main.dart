import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/service/shared_perference_service.dart';
import 'package:dating_app/screens/bottom_navigation/page/tab_bar.dart';
import 'package:dating_app/screens/create_profile/create_profile_page.dart';
import 'package:dating_app/screens/create_profile/more_about_you/page/more_about_you_page.dart';
import 'package:dating_app/screens/create_profile/personal_details/page/Personal_details_page.dart';
import 'package:dating_app/screens/create_profile/Photo/upload_photos/page/upload_image_page.dart';
import 'package:dating_app/screens/create_profile/user_preference/page/user_preference_page.dart';
import 'package:dating_app/screens/edit%20profile/page/edit_profile_page.dart';
import 'package:dating_app/screens/home/page/home_page.dart';
import 'package:dating_app/screens/profile/page/profile_page.dart';
import 'package:dating_app/screens/sign_in/page/sign_in_page.dart';
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
      home: UploadImagePage(),
    );
  }
}
