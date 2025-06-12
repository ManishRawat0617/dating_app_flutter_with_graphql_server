class UserModel {
  final String name;
  final String email;
  final String age;
  final String dateOfBirth;
  final String gender;
  final String bio;
  final String occupation;
  final String location;
  final String instagram;
  final String phone_number;

  UserModel({
    required this.name,
    required this.email,
    required this.phone_number,
    required this.age,
    required this.dateOfBirth,
    required this.gender,
    required this.bio,
    required this.occupation,
    required this.location,
    required this.instagram,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'email': email,
      'phone_number': phone_number,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'bio': bio,
      'occupation': occupation,
      'location': location,
      'instagram': instagram,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      age: map['age'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      phone_number: map['phone_number'] ?? '',
      gender: map['gender'] ?? '',
      bio: map['bio'] ?? '',
      occupation: map['occupation'] ?? '',
      location: map['location'] ?? '',
      instagram: map['instagram'] ?? '',
    );
  }
}
