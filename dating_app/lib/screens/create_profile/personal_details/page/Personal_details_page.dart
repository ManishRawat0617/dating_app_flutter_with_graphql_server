import 'package:dating_app/core/utilis/snackbar/ShowToast.dart';
import 'package:dating_app/screens/create_profile/more_about_you/page/more_about_you_page.dart';
import 'package:dating_app/screens/create_profile/bloc/personal_details_bloc.dart';
import 'package:dating_app/screens/create_profile/personal_details/widget/personal_details_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalDetailsPage extends StatelessWidget {
  PersonalDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PersonalDetailsBloc(), child: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<PersonalDetailsBloc, PersonalDetailsState>(
      listener: (context, state) {
        if (state is NextPageMoreAboutYouState) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MoreAboutYouPage()),
            );
          });
        } else if (state is ErrorState) {
          ShowToast.display(message: state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: PersonalDetailsContent(),
        );
      },
    );
  }
}
