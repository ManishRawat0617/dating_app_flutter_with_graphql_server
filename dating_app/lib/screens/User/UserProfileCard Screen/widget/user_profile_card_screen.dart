import 'package:dating_app/core/constants/capitalizeFirstLetter.dart';
import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/icons_constant.dart';
import 'package:dating_app/screens/User/UserProfileCard%20Screen/widget/image_grid.dart';
import 'package:dating_app/screens/User/UserProfileCard%20Screen/widget/lifestyleRow.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/iconoir.dart';
import 'package:dating_app/screens/User/UserProfileCard%20Screen/widget/full_screen_image.dart';
import 'package:iconly/iconly.dart';

class UserProfilePage extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final String name = capitalizeEachWord(user['name'] ?? 'Unknown');
    final int age = user['age'] ?? 0;
    final String image = user['image'] ??
        'https://via.placeholder.com/150'; // fallback if no image
    final String bio = user['bio'] ?? 'No bio available';
    final String location = user['location'] ?? 'Unknown';
    final String occupation = user['occupation'] ?? 'Not specified';
    final List<String> interests = List<String>.from(user['interests'] ?? []);
    final List<String> photos = List<String>.from(user['photos'] ?? []);
    final Map<String, dynamic> lifestyle = user['lifestyle'] ?? {};
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorConstants.background,
      appBar: AppBar(
        title: TextWidget(
          title: name,
          textColor: Colors.white,
          boldness: FontWeight.w700,
        ),
        backgroundColor: ColorConstants.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Profile Image
              Container(
                margin: const EdgeInsets.all(16),
                width: size.width * 0.9 ?? 150,
                height: size.width * 0.9 ?? 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),

              // Name and Age
              TextWidget(
                title: "$name, $age",
                textSize: 24,
                textColor: ColorConstants.textColor1,
                boldness: FontWeight.bold,
              ),

              const SizedBox(height: 8),

              // Location
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on, color: ColorConstants.textGrey),
                  const SizedBox(
                    width: 5,
                  ),
                  TextWidget(
                      title: location,
                      textSize: 14,
                      textColor: ColorConstants.textGrey,
                      boldness: FontWeight.w500),
                ],
              ),

              const SizedBox(height: 16),

              // Bio
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextWidget(
                    title: bio,
                    textSize: 16,
                    textColor: ColorConstants.textBlack,
                    boldness: FontWeight.w500),
              ),
              const SizedBox(height: 20),

              // Other Details
              ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: ColorConstants.textColor1,
                      width: 2,
                    ),
                  ),
                  leading: const Icon(
                    IconlyLight.work,
                    size: 28,
                    color: ColorConstants.textColor1,
                  ),
                  title: const TextWidget(
                      title: "Occupation",
                      textSize: 17,
                      textColor: ColorConstants.textColor1,
                      boldness: FontWeight.bold),
                  subtitle: TextWidget(
                      title: capitalizeEachWord(occupation),
                      textSize: 14,
                      textColor: ColorConstants.textColor4,
                      boldness: FontWeight.w500)),
              SizedBox(
                height: 10,
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: ColorConstants.textColor1,
                    width: 2,
                  ),
                ),
                leading: const Icon(IconlyLight.heart,
                    size: 28, color: ColorConstants.textColor1),
                title: const TextWidget(
                    title: "Interests",
                    textSize: 17,
                    textColor: ColorConstants.textColor1,
                    boldness: FontWeight.bold),
                subtitle: Wrap(
                  spacing: 8,
                  children: interests
                      .map((interest) => Chip(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Colors.grey, width: 1.5),
                            ),
                            label: TextWidget(
                              title: capitalizeEachWord(interest),
                              textSize: 14,
                              boldness: FontWeight.w500,
                            ),
                          ))
                      .toList(),
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              // Lifestyle Section
              if (lifestyle.isNotEmpty) buildLifestyleDetails(lifestyle),
              const SizedBox(
                height: 15,
              ),
              // Photo Gallery
              if (photos.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: TextWidget(
                    title: 'Photo Gallery',
                    textSize: 20,
                    textAlign: TextAlign.center,
                    boldness: FontWeight.bold,
                    textColor: ColorConstants.textColor1,
                  ),
                ),
                ImageGrid(photos: photos),
              ],
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLifestyleDetails(Map<String, dynamic> lifestyle) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorConstants.textColor1,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const TextWidget(
                title: 'Lifestyle Details',
                textSize: 20,
                textAlign: TextAlign.center,
                boldness: FontWeight.bold,
                textColor: ColorConstants.textColor1),
            const SizedBox(height: 6),
            Divider(
              color: ColorConstants.textColor1.withOpacity(0.5),
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(height: 6),
            buildLifestyleRow(
              'Smoking',
              lifestyle['smoking'] == true ? 'Yes' : 'No',
              IconsConstant.smoking,
            ),
            buildLifestyleRow(
              'Drinking',
              lifestyle['drinking'] == true ? 'Yes' : 'No',
              IconsConstant.drinking,
            ),
            buildLifestyleRow('Pets', lifestyle['pets'] == true ? 'Yes' : 'No',
                IconsConstant.pets),
            buildLifestyleRow(
                'Wants Kids',
                lifestyle['wants_kids'] == true ? 'Yes' : 'No',
                IconsConstant.kids),
            buildLifestyleRow(
                'Dietary Preference',
                lifestyle['dietary_preference'] ?? 'Not specified',
                IconsConstant.vegetarian),
            buildLifestyleRow(
                'Relationship Goal',
                lifestyle['relationship_goal'] ?? 'Not specified',
                IconsConstant.relationship),
            buildLifestyleRow(
                'Fitness Level',
                lifestyle['fitness_level'] ?? 'Not specified',
                IconsConstant.fitness),
            buildLifestyleRow(
                'Religion',
                lifestyle['religion'] ?? 'Not specified',
                IconsConstant.relationship),
            buildLifestyleRow(
                'Sleep Schedule',
                lifestyle['sleep_schedule'] ?? 'Not specified',
                IconsConstant.sleep),
          ],
        ),
      ),
    );
  }
}
