import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/text_constants.dart';
import 'package:dating_app/screens/User/UserProfileCard%20Screen/widget/user_profile_card_screen.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class PersonProfileCard extends StatelessWidget {
  const PersonProfileCard({
    super.key,
    required this.person,
    required this.showLike,
    required this.showNope,
  });

  final Map<String, String> person;
  final bool showLike;
  final bool showNope;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        // border: Border.all(
        //   color: ColorConstants.grey,
        //   width: 2,
        // ),
      ),
      child: Stack(children: [
        Positioned(
          top: 18,
          left: 20,
          right: 20,
          child: Container(
            height: 350,
            width: 300,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserProfilePage(
                            user: {
                              'name': 'emma watson',
                              'age': 26,
                              'image':
                                  'https://randomuser.me/api/portraits/women/21.jpg',
                              'bio': 'Love hiking and photography.',
                              'location': 'London, UK',
                              'occupation': 'Software Engineer',
                              'interests': ['travel', 'books', 'music'],
                              'photos': [
                                'https://randomuser.me/api/portraits/women/21.jpg',
                                'https://randomuser.me/api/portraits/women/45.jpg',
                                'https://randomuser.me/api/portraits/women/55.jpg',
                                'https://randomuser.me/api/portraits/women/21.jpg',
                                'https://randomuser.me/api/portraits/women/45.jpg',
                                'https://randomuser.me/api/portraits/women/55.jpg',
                              ],
                              "lifestyle": {
                                "smoking": false,
                                "drinking": true,
                                "pets": true,
                                "wants_kids": false,
                                "dietary_preference": "Vegetarian",
                                "relationship_goal": "Long Term",
                                "fitness_level": "Moderate",
                                "religion": "Spiritual",
                                "sleep_schedule": "Early Riser"
                              }
                            },
                          ),
                        ),
                      );
                    },
                    child: Image.asset(
                      person['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //       begin: Alignment.topCenter,
                  //       end: Alignment.bottomCenter,
                  //       colors: [
                  //         Colors.transparent,
                  //         Colors.black.withOpacity(0.6),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  if (showLike)
                    const Positioned(
                      top: 40,
                      left: 20,
                      child: BadgeWidget(
                        text: HomePageText.likeProfile,
                        color: ColorConstants.profileLikeColor,
                        angle: -15,
                      ),
                    ),
                  if (showNope)
                    const Positioned(
                      top: 40,
                      right: 20,
                      child: BadgeWidget(
                        text: HomePageText.dislikeProfle,
                        color: ColorConstants.profiledislikeColor,
                        angle: 15,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 20,
          bottom: 15,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                title: person['name']!,
                textSize: 26,
                textColor: ColorConstants.textColor1,
                boldness: FontWeight.bold,
              ),
              TextWidget(
                title: '${person['age']} years old',
                textColor: ColorConstants.textColor1,
                boldness: FontWeight.bold,
                textSize: 14,
              ),
              const SizedBox(height: 30),
              const ProfileActionOptions()
            ],
          ),
        ),
      ]),
    );
  }
}

class ProfileActionOptions extends StatelessWidget {
  const ProfileActionOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double spaceBtw = 20;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => AppSettingsPage(),
            //   ),
            // );
          },
          child: CircleAvatar(
            backgroundColor: Colors.grey.withOpacity(0.25),
            radius: 24,
            child: const Icon(
              IconlyLight.tick_square,
              color: Colors.green,
              size: 28,
            ),
          ),
        ),
        SizedBox(width: spaceBtw),
        InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => AppSettingsPage(),
            //   ),
            // );
          },
          child: CircleAvatar(
            backgroundColor: Colors.grey.withOpacity(0.25),
            radius: 24,
            child: const Icon(
              IconlyLight.heart,
              color: Colors.pink,
              size: 28,
            ),
          ),
        ),
        SizedBox(width: spaceBtw),
        InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => AppSettingsPage(),
            //   ),
            // );
          },
          child: CircleAvatar(
            backgroundColor: Colors.grey.withOpacity(0.25),
            radius: 24,
            child: const Icon(
              IconlyLight.close_square,
              color: Colors.blue,
              size: 28,
            ),
          ),
        ),
        SizedBox(width: spaceBtw),
        InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => AppSettingsPage(),
            //   ),
            // );
          },
          child: CircleAvatar(
            backgroundColor: Colors.grey.withOpacity(0.25),
            radius: 24,
            child: const Icon(
              Icons.more_horiz,
              color: Colors.blue,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }
}

// Helper widget for "LIKE" and "NOPE" badge
class BadgeWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double angle;

  const BadgeWidget({
    super.key,
    required this.text,
    required this.color,
    required this.angle,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * 3.1416 / 180,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
