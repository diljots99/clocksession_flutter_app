class LoginRequest {
  final String email;
  final String password;

  const LoginRequest({
    required this.email,
    required this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      password: json['password'],
      email: json['email'],
    );
  }
  // factory LoginRequest.toJson(LoginRequest object) {
  //   Map<String, dynamic> json = {
  //     "email": object.email,
  //     "password": object.password
  //   };
  //   return json;
  // }
}
