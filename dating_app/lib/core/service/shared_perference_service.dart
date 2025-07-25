import 'dart:convert';

import 'package:dating_app/data/models/userLifestyleModel.dart';
import 'package:dating_app/data/models/userModel.dart';
import 'package:dating_app/data/models/userPersonalityDetailsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ------------------- Setters -------------------

  static Future<void> saveUser(UserModel user) async {
    final jsonString = jsonEncode(user.toMap());
    await _prefs?.setString('user_model', jsonString);
  }

  static Future<void> saveUserLifestyle(UserLifestyle userLifestyle) async {
    final jsonString = jsonEncode(userLifestyle.toMap());
    await _prefs?.setString('user_lifestyle', jsonString);
  }

  static Future<void> saveUserPersonality(
      UserPersonalityDetails userPersonalityDetails) async {
    final jsonString = jsonEncode(userPersonalityDetails.toMap());
    await _prefs?.setString('user_personality', jsonString);
  }

  static Future<void> setIsLoggedIn(bool value) async =>
      await _prefs?.setBool('isLoggedIn', value);

  static Future<void> setAuthToken(String value) async =>
      await _prefs?.setString("authToken", value);

  static Future<void> setName(String value) async =>
      await _prefs?.setString("name", value);

  static Future<void> setEmail(String value) async =>
      await _prefs?.setString("email", value);

  static Future<void> setUserID(String value) async =>
      await _prefs?.setString("userID", value);

  static Future<void> setFirstName(String firstName) async =>
      await _prefs?.setString('firstName', firstName);

  static Future<void> setLastName(String lastName) async =>
      await _prefs?.setString('lastName', lastName);

  static Future<void> setAge(String age) async =>
      await _prefs?.setString('age', age);

  static Future<void> setDateOfBirth(String dateOfBirth) async =>
      await _prefs?.setString('dateOfBirth', dateOfBirth);

  static Future<void> setGender(String gender) async =>
      await _prefs?.setString('gender', gender);

  static Future<void> setSexualOrientation(String sexualOrientation) async =>
      await _prefs?.setString('sexualOrientation', sexualOrientation);

  static Future<void> setBio(String bio) async =>
      await _prefs?.setString('bio', bio);

  static Future<void> setOccupation(String occupation) async =>
      await _prefs?.setString('occupation', occupation);

  static Future<void> setLocation(String location) async =>
      await _prefs?.setString('location', location);

  static Future<void> setInstagram(String instagram) async =>
      await _prefs?.setString('instagram', instagram);

  static Future<void> setRelationshipType(String relationshipType) async =>
      await _prefs?.setString('relationshipType', relationshipType);

  static Future<void> setAgeRange(double minAge, double maxAge) async {
    await _prefs?.setDouble('minAge', minAge);
    await _prefs?.setDouble('maxAge', maxAge);
  }

  static Future<void> setDistance(double distanceKm) async =>
      await _prefs?.setDouble('distanceKm', distanceKm);

  static Future<void> setGenderInterestedIn(String gender) async =>
      await _prefs?.setString('genderInterestedIn', gender);

  static Future<void> setReligionInterestedIn(String religion) async =>
      await _prefs?.setString('religionInterestedIn', religion);

  // ------------------- Getters -------------------

  static UserModel? getUser() {
    final jsonString = _prefs?.getString('user_model');
    if (jsonString == null) return null;

    final map = jsonDecode(jsonString);
    return UserModel.fromMap(map);
  }

  static UserLifestyle? getUserLifestyle() {
    final jsonString = _prefs?.getString('user_lifestyle');
    if (jsonString == null) return null;

    final map = jsonDecode(jsonString);
    return UserLifestyle.fromMap(map);
  }

  static UserPersonalityDetails? getUserPersonality() {
    final jsonString = _prefs?.getString('user_personality');
    if (jsonString == null) return null;

    final map = jsonDecode(jsonString);
    return UserPersonalityDetails.fromMap(map);
  }

  static bool getIsLoggedIn() => _prefs?.getBool('isLoggedIn') ?? false;

  static String? getAuthToken() => _prefs?.getString("authToken");

  static String? getUserID() => _prefs?.getString("userID");

  static String? getName() => _prefs?.getString("name");

  static String? getEmail() => _prefs?.getString("email");

  static String? getFirstName() => _prefs?.getString('firstName');

  static String? getLastName() => _prefs?.getString('lastName');

  static String? getAge() => _prefs?.getString('age');

  static String? getDateOfBirth() => _prefs?.getString('dateOfBirth');

  static String? getGender() => _prefs?.getString('gender');

  static String? getSexualOrientation() =>
      _prefs?.getString('sexualOrientation');

  static String? getBio() => _prefs?.getString('bio');

  static String? getOccupation() => _prefs?.getString('occupation');

  static String? getLocation() => _prefs?.getString('location');

  static String getInstagram() => _prefs?.getString('instagram') ?? '';
  static String? getRelationshipType() => _prefs?.getString('relationshipType');

  static double? getMinAge() => _prefs?.getDouble('minAge');
  static double? getMaxAge() => _prefs?.getDouble('maxAge');

  static double? getDistanceKm() => _prefs?.getDouble('distanceKm');

  static String? getGenderInterestedIn() =>
      _prefs?.getString('genderInterestedIn');

  static String? getReligionInterestedIn() =>
      _prefs?.getString('religionInterestedIn');

  // ------------------- Utilities -------------------
  static Future<void> clearAll() async => await _prefs?.clear();

  static Future<void> removeKey(String key) async => await _prefs?.remove(key);
}
