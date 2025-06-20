import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/text_constants.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:dating_app/screens/create_profile/lifestyle/bloc/lifestyle_page_bloc.dart';
import 'package:dating_app/screens/create_profile/lifestyle/widget/lifestyle_content.dart';
import 'package:dating_app/screens/create_profile/personal_details/page/Personal_details_page.dart';
import 'package:dating_app/screens/create_profile/personality/widget/personality_quizz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LifestylePage extends StatelessWidget {
  const LifestylePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LifestylePageBloc(),
      child: const _LifestyleView(),
    );
  }
}

class _LifestyleView extends StatelessWidget {
  const _LifestyleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LifestylePageBloc, LifestylePageState>(
      listener: (context, state) {
        if (state is LifestylePageSuccessState) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FullPersonalityQuizScreen()));
        }
      },
      builder: (context, state) {
        return Scaffold(
         
          body: const LifestyleDetailsContent(),
        );
      },
    );
  }
}
