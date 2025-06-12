import 'package:dating_app/core/service/shared_perference_service.dart';
import 'package:dating_app/data/models/userModal.dart';
import 'package:dating_app/screens/sign_up/graphql/signup_graph.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';

class CreateProfilePage extends StatelessWidget {
  const CreateProfilePage({super.key});

  Future<void> updateUser() async {
    try {
      SignupGraphql().updateUser(
        id: "a97e929e-6daf-449b-acf2-a1dc2ac89ab4",

        age: int.tryParse(SharedPrefsService.getAge() ?? '') ?? 0,
        name: (SharedPrefsService.getFirstName().toString() +
            " " +
            SharedPrefsService.getLastName().toString()),
        // dateOfBirth: SharedPrefsService.getDateOfBirth().toString(),
        gender: SharedPrefsService.getGender(),
        bio: SharedPrefsService.getBio(),
        occupation: SharedPrefsService.getOccupation(),
        location: SharedPrefsService.getLocation(),
        // instagram: SharedPrefsService.getInstagram(),
      );
    } catch (e) {
      print(e);
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),
            TextWidget(
              boldness: FontWeight.bold,
              title:
                  "Please ensure that all the information you provide is accurate and honest. "
                  "This will help us create a trustworthy and meaningful experience for you and other users. "
                  "Profiles with authentic details have a higher chance of making real connections.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            InkWell(
              onTap: () {
                updateUser();
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.pinkAccent.shade100,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
