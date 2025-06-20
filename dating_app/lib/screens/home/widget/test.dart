import 'package:dating_app/core/constants/text_constants.dart';
import 'package:dating_app/screens/common_widget/loading_widget.dart';
import 'package:dating_app/screens/home/bloc/home_page_bloc.dart';
import 'package:dating_app/screens/home/widget/person_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:dating_app/core/constants/color_constants.dart';
import 'package:iconly/iconly.dart';

class HomeContext extends StatelessWidget {
  HomeContext({super.key});

  final List<Map<String, String>> people = [
    {
      'name': 'Sabila Sayma',
      'age': '24',
      'image': 'assets/images/chiku.png',
    },
    {
      'name': 'Lina Gomez',
      'age': '22',
      'image': 'assets/images/chiku.png',
    },
    {
      'name': 'Olivia Smith',
      'age': '25',
      'image': 'assets/images/chiku.png',
    },
    {
      'name': 'Sabila Sayma',
      'age': '24',
      'image': 'assets/images/chiku.png',
    },
    {
      'name': 'Lina Gomez',
      'age': '22',
      'image': 'assets/images/chiku.png',
    },
    {
      'name': 'Olivia Smith',
      'age': '25',
      'image': 'assets/images/chiku.png',
    },
    {
      'name': 'Sabila Sayma',
      'age': '24',
      'image': 'assets/images/chiku.png',
    },
    {
      'name': 'Lina Gomez',
      'age': '22',
      'image': 'assets/images/chiku.png',
    },
    {
      'name': 'Olivia Smith',
      'age': '25',
      'image': 'assets/images/chiku.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorConstants.white,
        child: Stack(
          children: [
            _createMainBody(context),
            BlocBuilder<HomeBloc, HomePageState>(
              buildWhen: (prev, curr) =>
                  curr is LoadingState ||
                  curr is ErrorState ||
                  curr is ProfileLoadingState,
              builder: (context, state) {
                if (state is LoadingState) {
                  return LoadingWidget();
                }
                return const SizedBox();
              },
            )
          ],
        ));
  }

  Widget _createMainBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<HomeBloc>(context);
    return SafeArea(
      child: people.isEmpty
          ? const Center(
              child: Text(
                HomePageText.noMoreProfile,
                style: TextStyle(fontSize: 18),
              ),
            )
          : Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.05,
                right: size.width * 0.05,
                top: size.height * 0.02,
                bottom: size.height * 0.03,
              ),
              child: CardSwiper(
                cardsCount: people.length,
                numberOfCardsDisplayed: 3,
                padding: EdgeInsets.zero,
                isLoop: false,
                allowedSwipeDirection:
                    const AllowedSwipeDirection.only(left: true, right: true),
                cardBuilder:
                    (context, index, percentThresholdX, percentThresholdY) {
                  final person = people[index];

                  bool showLike = percentThresholdX > 0.4;
                  bool showNope = percentThresholdX < -0.4;

                  // return PersonProfileCard(
                  //     person: person, showLike: bloc.add(SwipeRightEvent()), showNope: showNope);
                },
              ),
            ),
    );
  }
}
