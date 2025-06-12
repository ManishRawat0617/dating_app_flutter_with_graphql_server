import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ------------------- Setters -------------------
  static Future<void> setIsLoggedIn(bool value) async =>
      await _prefs?.setBool('isLoggedIn', value);

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

  // ------------------- Getters -------------------
  static bool getIsLoggedIn() => _prefs?.getBool('isLoggedIn') ?? false;

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

  // ------------------- Utilities -------------------
  static Future<void> clearAll() async => await _prefs?.clear();

  static Future<void> removeKey(String key) async => await _prefs?.remove(key);
}
