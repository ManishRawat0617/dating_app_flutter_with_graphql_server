class UserPersonalityDetails {
  final String personalityType;
  final String zodiacSign;
  final String politicalView;
  final String loveLanguage;
  final String humorStyle;

  UserPersonalityDetails({
    required this.personalityType,
    required this.zodiacSign,
    required this.politicalView,
    required this.loveLanguage,
    required this.humorStyle,
  });

  Map<String, dynamic> toMap() {
    return {
      'personalityType': personalityType,
      'zodiacSign': zodiacSign,
      'politicalView': politicalView,
      'loveLanguage': loveLanguage,
      'humorStyle': humorStyle,
    };
  }

  factory UserPersonalityDetails.fromMap(Map<String, dynamic> map) {
    return UserPersonalityDetails(
      personalityType: map['personalityType'] ?? '',
      zodiacSign: map['zodiacSign'] ?? '',
      politicalView: map['politicalView'] ?? '',
      loveLanguage: map['loveLanguage'] ?? '',
      humorStyle: map['humorStyle'] ?? '',
    );
  }
}
