import 'package:dating_app/screens/create_profile/personal_details/bloc/personal_details_bloc.dart';
import 'package:dating_app/screens/create_profile/personal_details/widget/personal_details_content.dart';
import 'package:dating_app/screens/create_profile/quick_introduction/widget/quick_introduction_content.dart';
import 'package:dating_app/screens/create_profile/user_preference/widget/user_preference_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadImagePage extends StatelessWidget {
  UploadImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PersonalDetailsBloc(), child: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<PersonalDetailsBloc, PersonalDetailsState>(
      listener: (context, state) {
        if (state is NextPageQuickIntroductionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => QuickIntroductionContent()));
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
          body: UploadImagePage(), // assuming this uses the bloc
        );
      },
    );
  }
}
