import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/text_constants.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:dating_app/screens/home/bloc/home_page_bloc.dart';
import 'package:dating_app/screens/home/widget/home_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(),
        child: BlocConsumer<HomeBloc, HomePageState>(
          buildWhen: (previous, current) => current is HomeInitialState,
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: ColorConstants.primary,
                elevation: 0.5,
                title: const TextWidget(
                  title: HomePageText.discover,
                  boldness: FontWeight.bold,
                  textColor: ColorConstants.white,
                  textSize: 26,
                ),
                centerTitle: true,
              ),
              body: HomeContext(),
            );
          },
          listenWhen: (previous, current) => true,
          listener: (context, state) {},
        ));
  }
}
