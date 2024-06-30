import 'dart:convert';

class ResultLogin {
  final String accessToken;
  final String refreshToken;
  final String username;
  final String email;
  final String role;
  ResultLogin({
    required this.accessToken,
    required this.refreshToken,
    required this.username,
    required this.email,
    required this.role,
  });
  //from Json
  factory ResultLogin.fromJson(Map<String, dynamic> json) {
    return ResultLogin(
        accessToken: json['access_token'],
        refreshToken: json["refresh_token"],
        username: json['data']['username'],
        email: json['data']['email'],
      role: json['data']['role'],
    ); }
}
ResultLogin resultLoginFromJson(String str)  => ResultLogin.fromJson(json.decode(str));