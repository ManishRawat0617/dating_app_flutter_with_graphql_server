// import 'package:flutter/material.dart';

// class LikesYouPage extends StatelessWidget {
//   LikesYouPage({super.key});

//   // Mock data - users who liked you
//   final List<Map<String, String>> likes = [
//     {
//       'name': 'Emma Johnson',
//       'age': '23',
//       'image': 'https://randomuser.me/api/portraits/women/21.jpg',
//     },
//     {
//       'name': 'Sophia Lee',
//       'age': '26',
//       'image': 'https://randomuser.me/api/portraits/women/32.jpg',
//     },
//     {
//       'name': 'Ava Brown',
//       'age': '22',
//       'image': 'https://randomuser.me/api/portraits/women/45.jpg',
//     },
//     {
//       'name': 'Mia Davis',
//       'age': '24',
//       'image': 'https://randomuser.me/api/portraits/women/55.jpg',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.5,
//         centerTitle: true,
//         title: const Text(
//           'Likes You',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//         ),
//       ),
//       body: likes.isEmpty
//           ? const Center(
//               child: Text(
//                 'No one liked you yet 😔',
//                 style: TextStyle(fontSize: 18),
//               ),
//             )
//           : GridView.builder(
//               padding: const EdgeInsets.all(16),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//                 childAspectRatio: 0.7,
//               ),
//               itemCount: likes.length,
//               itemBuilder: (context, index) {
//                 final person = likes[index];
//                 return Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 8,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         Image.network(
//                           person['image']!,
//                           fit: BoxFit.cover,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               begin: Alignment.bottomCenter,
//                               end: Alignment.topCenter,
//                               colors: [
//                                 Colors.black.withOpacity(0.7),
//                                 Colors.transparent,
//                               ],
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 12,
//                           left: 12,
//                           right: 12,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 person['name']!,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 '${person['age']} years old',
//                                 style: const TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:dating_app/core/constants/api_constants.dart';
import 'package:dating_app/core/constants/capitalizeFirstLetter.dart';
import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/service/shared_perference_service.dart';
import 'package:dating_app/screens/like_your_profile/graphql/like_your_profile_page_graphql.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class LikesYouPage extends StatefulWidget {
  const LikesYouPage({super.key});

  @override
  State<LikesYouPage> createState() => _LikesYouPageState();
}

class _LikesYouPageState extends State<LikesYouPage> {
  List<Map<String, dynamic>> likes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLikes();
  }

  Future<void> fetchLikes() async {
    // final userId = await SharedPreferenceService.getUserId(); // Assuming you store it
    final result = await getLikesToUser(
        userId: "ab75b81b-a237-4253-ae4e-65bb5e0ac7c7"); // Your GraphQL call
    setState(() {
      likes = result as List<Map<String, dynamic>>;
      print(likes);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorConstants.primary,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          'Likes You',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : likes.isEmpty
              ? const Center(
                  child: Text(
                    'No likes yet 😢',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: likes.length,
                  itemBuilder: (context, index) {
                    final person = likes[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              ApiEndpoints.basic_address +
                                      "3000" +
                                      person['profile_photo_url'] ??
                                  '', // handle nulls
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(IconlyLight.user),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  capitalizeEachWord(person['liker_name']) ??
                                      'Unknown',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${person['liker_age'] ?? '--'} years old',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            IconlyLight.heart,
                            color: Colors.pink,
                            size: 28,
                          )
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
