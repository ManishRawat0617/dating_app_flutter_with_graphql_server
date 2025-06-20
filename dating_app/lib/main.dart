import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/service/shared_perference_service.dart';
import 'package:dating_app/screens/User/UserProfileCard%20Screen/widget/user_profile_card_screen.dart';
import 'package:dating_app/screens/app_settings/page/app_settings_page.dart';
import 'package:dating_app/screens/app_settings/widget/app_setting_context.dart';
import 'package:dating_app/screens/bottom_navigation/page/tab_bar.dart';
import 'package:dating_app/screens/create_profile/Photo/upload_photos/page/upload_image_page.dart';
import 'package:dating_app/screens/create_profile/Photo/verify_user/page/verify_user_page.dart';
import 'package:dating_app/screens/create_profile/create_profile_page.dart';
import 'package:dating_app/screens/create_profile/lifestyle/page/lifestyle_page.dart';
import 'package:dating_app/screens/create_profile/personal_details/page/Personal_details_page.dart';
import 'package:dating_app/screens/create_profile/personality/page/personality_page.dart';
import 'package:dating_app/screens/create_profile/personality/widget/personality_quizz.dart';
import 'package:dating_app/screens/create_profile/phone_number_entering_view/widget/phone_number_content.dart';
import 'package:dating_app/screens/sign_in/page/sign_in_page.dart';
import 'package:dating_app/screens/sign_up/page/sign_up_page.dart';
import 'package:dating_app/screens/splash_screen/splash_screen.dart';
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
      home: BottomNavBar(),
      // home: UserProfilePage(
      //   user: {
      //     'name': 'emma watson',
      //     'age': 26,
      //     'image': 'https://randomuser.me/api/portraits/women/21.jpg',
      //     'bio': 'Love hiking and photography.',
      //     'location': 'London, UK',
      //     'occupation': 'Software Engineer',
      //     'interests': ['travel', 'books', 'music'],
      //     'photos': [
      //       'https://randomuser.me/api/portraits/women/21.jpg',
      //       'https://randomuser.me/api/portraits/women/45.jpg',
      //       'https://randomuser.me/api/portraits/women/55.jpg',
      //       'https://randomuser.me/api/portraits/women/21.jpg',
      //       'https://randomuser.me/api/portraits/women/45.jpg',
      //       'https://randomuser.me/api/portraits/women/55.jpg',
      //     ],
      //     "lifestyle": {
      //       "smoking": false,
      //       "drinking": true,
      //       "pets": true,
      //       "wants_kids": false,
      //       "dietary_preference": "Vegetarian",
      //       "relationship_goal": "Long Term",
      //       "fitness_level": "Moderate",
      //       "religion": "Spiritual",
      //       "sleep_schedule": "Early Riser"
      //     }
      //   },
      // ),
    );
  }
}
