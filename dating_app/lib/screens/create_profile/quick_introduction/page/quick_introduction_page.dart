import 'package:dating_app/screens/create_profile/bloc/personal_details_bloc.dart';
import 'package:dating_app/screens/create_profile/personal_details/widget/personal_details_content.dart';
import 'package:dating_app/screens/create_profile/quick_introduction/widget/quick_introduction_content.dart';
import 'package:dating_app/screens/create_profile/user_preference/page/user_preference_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuickIntroductionPage extends StatelessWidget {
  QuickIntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PersonalDetailsBloc(), child: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<PersonalDetailsBloc, PersonalDetailsState>(
      listener: (context, state) {
        if (state is NextPageUserPreferencesState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => UserPreferencePage()));
        } else if (state is ErrorState) {
          print("Error: ${state.message}");
          // ScaffoldMessenger.of(context)
          //   ..hideCurrentSnackBar()
          //   ..showSnackBar(StatusSnackbar.show(
          //     title: 'Error',
          //     message: state.message,
          //     contentType: ContentType.success,
          //   ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: QuickIntroductionContent(), // assuming this uses the bloc
        );
      },
    );
  }
}
