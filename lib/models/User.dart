class User {
  final int id;
  final String token;
  final String name;
  final String email;
  final String date_of_birth;
  final String mobile_number;
  final int screenshots;
  final bool screenshot_active;
  final String profile_image;
  final bool allow_manual_time;

  const User({
    required this.id,
    required this.token,
    required this.name,
    required this.email,
    required this.date_of_birth,
    required this.mobile_number,
    required this.screenshots,
    required this.screenshot_active,
    required this.profile_image,
    required this.allow_manual_time,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      date_of_birth: json['date_of_birth'],
      mobile_number: json['mobile_number'],
      screenshots: json['screenshots'],
      screenshot_active: json['screenshot_active'],
      profile_image: json['profile_image'],
      allow_manual_time: json['allow_manual_time'],
    );
  }
}
