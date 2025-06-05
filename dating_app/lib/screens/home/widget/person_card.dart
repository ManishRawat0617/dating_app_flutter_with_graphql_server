import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class PerssonCard extends StatelessWidget {
  const PerssonCard({
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
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              person['image']!,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
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
            Positioned(
              left: 20,
              bottom: 30,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person['name']!,
                    style: const TextStyle(
                      color: ColorConstants.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${person['age']} years old',
                    style: const TextStyle(
                      color: ColorConstants.white70,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const ProfileActionOptions()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileActionOptions extends StatelessWidget {
  const ProfileActionOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 24,
          child: Icon(
            IconlyLight.tick_square,
            color: Colors.green,
            size: 28,
          ),
        ),
        SizedBox(width: 16),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 24,
          child: Icon(
            IconlyLight.heart,
            color: Colors.pink,
            size: 28,
          ),
        ),
        const SizedBox(width: 16),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 24,
          child: Icon(
            Icons.directions_walk_outlined,
            color: Colors.blue,
            size: 28,
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
