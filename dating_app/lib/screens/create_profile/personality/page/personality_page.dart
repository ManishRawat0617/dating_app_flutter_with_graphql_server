// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:dating_app/screens/create_profile/Photo/upload_photos/page/upload_image_page.dart';
import 'package:dating_app/screens/create_profile/personality/bloc/personality_page_bloc.dart';
import 'package:dating_app/screens/create_profile/personality/widget/personality_page_content.dart';

class PersonalityPage extends StatelessWidget {
  final String personalityType;

  const PersonalityPage({
    Key? key,
    required this.personalityType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PersonalityPageBloc(),
      child: _PersonalityView(personalityType: personalityType),
    );
  }
}

class _PersonalityView extends StatelessWidget {
  final String personalityType;

  const _PersonalityView({Key? key, required this.personalityType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalityPageBloc, PersonalityPageState>(
      listener: (context, state) {
        if (state is PersonalityPageSuccessState) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => UploadImagePage()),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: PersonalityDetailsContent(personalityType: personalityType),
        );
      },
    );
  }
}
