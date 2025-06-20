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
  // final Map<String, dynamic> person = {
  //   'name': 'Emma Johnson',
  //   'age': '24',
  //   'images': [
  //     'https://randomuser.me/api/portraits/women/21.jpg',
  //     'https://randomuser.me/api/portraits/women/45.jpg',
  //     'https://randomuser.me/api/portraits/women/55.jpg',
  //   ],
  // };
  final List<Map<String, String>> people = [
    {'name': 'Sabila Sayma', 'age': '24', 'image': 'assets/images/chiku.png'},
    {'name': 'Lina Gomez', 'age': '22', 'image': 'assets/images/chiku.png'},
    {'name': 'Olivia Smith', 'age': '25', 'image': 'assets/images/chiku.png'},

    // Add more as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(234, 228, 213, 1),
      child: Stack(
        children: [
          _createMainBody(context),
          BlocBuilder<HomeBloc, HomePageState>(
            buildWhen: (_, curr) =>
                curr is LoadingState ||
                curr is ErrorState ||
                curr is ProfileLoadingState,
            builder: (_, state) =>
                state is LoadingState ? LoadingWidget() : const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _createMainBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = context.read<HomeBloc>();

    return SafeArea(
      child: people.isEmpty
          ? const Center(
              child: Text(
                HomePageText.noMoreProfile,
                style: TextStyle(fontSize: 18),
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.02,
              ),
              child: CardSwiper(
                cardsCount: people.length,
                numberOfCardsDisplayed: 1,
                padding: EdgeInsets.zero,
                isLoop: true,
                allowedSwipeDirection: const AllowedSwipeDirection.only(
                  left: true,
                  right: true,
                ),
                onSwipe: (int previousIndex, int? currentIndex,
                    CardSwiperDirection direction) {
                  if (direction == CardSwiperDirection.left) {
                    bloc.add(const SwipeLeftEvent("dfsdnfv"));
                  } else if (direction == CardSwiperDirection.right) {
                    bloc.add(SwipeRightEvent("djsnvm"));
                  }
                  return true;
                },
                cardBuilder:
                    (context, index, percentThresholdX, percentThresholdY) {
                  final person = people[index];

                  bool showLike = percentThresholdX > 0.4;
                  bool showNope = percentThresholdX < -0.4;
                  return PersonProfileCard(
                    person: person,
                    showLike: showLike,
                    showNope: showNope,
                  );
                },
              ),
            ),
    );
  }
}
