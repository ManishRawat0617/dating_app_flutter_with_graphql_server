import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/screens/chatting/page/chat_inbox_page.dart';
import 'package:dating_app/screens/home/widget/home_context.dart';
import 'package:dating_app/screens/profile/page/profile_page.dart';
import 'package:dating_app/screens/profile/widget/profile_context.dart';
import 'package:dating_app/screens/subscription/page/subscription_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:iconly/iconly.dart';

class DatingAppHome extends StatefulWidget {
  @override
  _DatingAppHomeState createState() => _DatingAppHomeState();
}

class _DatingAppHomeState extends State<DatingAppHome> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeContext(),
    Center(child: Text('Matches')),
    ChatInboxPage(),
    SubscriptionPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 60.0,
        color: Colors.pinkAccent,
        buttonBackgroundColor: ColorConstants.primary,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 450),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: <Widget>[
          Icon(IconlyLight.home, size: 30, color: Colors.white),
          Icon(IconlyLight.heart, size: 30, color: Colors.white),
          Icon(IconlyLight.message, size: 30, color: Colors.white),
          Icon(IconlyLight.bag, size: 30, color: Colors.white),
          Icon(IconlyLight.profile, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}
