import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/screens/bottom_navigation/bloc/tab_bar_bloc.dart';
import 'package:dating_app/screens/chatting/page/chat_inbox_page.dart';
import 'package:dating_app/screens/home/page/home_page.dart';
import 'package:dating_app/screens/home/widget/home_context.dart';
import 'package:dating_app/screens/like_your_profile/like_your_profile_page.dart';
import 'package:dating_app/screens/User/profile%20screen/page/profile_page.dart';
import 'package:dating_app/screens/subscription/page/subscription_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // ignore: non_constant_identifier_names
  final List<Widget> _BottomNavBarIcons = [
    const Icon(IconlyLight.home, size: 30, color: Colors.white),
    const Icon(IconlyLight.heart, size: 30, color: Colors.white),
    const Icon(IconlyLight.message, size: 30, color: Colors.white),
    const Icon(IconlyLight.bag, size: 30, color: Colors.white),
    const Icon(IconlyLight.profile, size: 30, color: Colors.white),
  ];

  final List<Widget> _pages = [
    const HomePage(),
    LikesYouPage(),
    const ChatInboxPage(),
    const SubscriptionPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBarBloc>(
      create: (context) => TabBarBloc(),
      child: BlocConsumer<TabBarBloc, TabBarState>(
        listener: (context, state) {},
        builder: (context, state) {
          final bloc = BlocProvider.of<TabBarBloc>(context);
          return Scaffold(
            extendBody: true,
            body: _pages[bloc.currentIndex],
            bottomNavigationBar: _createBottomTabBar(context),
          );
        },
      ),
    );
  }

  Widget _createBottomTabBar(BuildContext context) {
    final bloc = BlocProvider.of<TabBarBloc>(context);
    return CurvedNavigationBar(
        index: bloc.currentIndex,
        height: 60.0,
        color: Colors.pinkAccent,
        buttonBackgroundColor: ColorConstants.primary,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 450),
        onTap: (index) {
          bloc.add(TabBarTappedEvent(index: index));
        },
        items: _BottomNavBarIcons);
  }
}
