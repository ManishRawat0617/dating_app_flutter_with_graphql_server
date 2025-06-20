import 'dart:convert';
import 'package:http/http.dart' as http;

class PythonAPI {
  Future<void> sendLifestyleDataToClusteringAPI({
    required String userId,
    required String dietaryPreference,
    required bool drinking,
    required String fitnessLevel,
    required bool pets,
    required String relationshipGoal,
    required String religion,
    required String sleepSchedule,
    required bool smoking,
    required bool wantsKids,
  }) async {
    final url = Uri.parse(
        'http://localhost:5001/assign-cluster'); // Use 10.0.2.2 for localhost on Android emulator

    final body = jsonEncode({
      "user_id": userId,
      "dietary_preference": dietaryPreference,
      "drinking": drinking,
      "fitness_level": fitnessLevel,
      "pets": pets,
      "relationship_goal": relationshipGoal,
      "religion": religion,
      "sleep_schedule": sleepSchedule,
      "smoking": smoking,
      "wants_kids": wantsKids,
    });

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print("Cluster assigned: ${result['cluster']}");
        // You can also store cluster ID in SharedPrefs if needed
      } else {
        print("Failed: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error sending data to clustering API: $e");
    }
  }
}
