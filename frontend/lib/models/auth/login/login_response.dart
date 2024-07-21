import 'dart:convert';


class ResultLogin {
  final String accessToken;
  final String refreshToken;
  final String username;
  final String email;
  final String role;
  final String avatar;
  ResultLogin({
    required this.accessToken,
    required this.refreshToken,
    required this.username,
    required this.email,
    required this.role,
    required this.avatar,
  });

  // xử lý ảnh của user
  static String _parseAvatar(Map<String, dynamic> json) {
    if (json['data']['avatar']['data'] != null) {
      List<int> imageData = List<int>.from(json['data']['avatar']['data']);
      return String.fromCharCodes(imageData);
    }
    return ''; // nếu không xử lý được trả về rỗg dể lấy ảnh mặc định.
  }

//from Json
  factory ResultLogin.fromJson(Map<String, dynamic> json) {
    String defaultImage =
        'https://firebasestorage.googleapis.com/v0/b/tn252-385da.appspot.com/o/user.png?alt=media&token=3417e5e4-2ee2-4bad-8384-b7e46181a4ee';
    String avatarUrl = _parseAvatar(json);
    if (avatarUrl.isEmpty) {
      avatarUrl = defaultImage;
    }
    return ResultLogin(
      accessToken: json['access_token'],
      refreshToken: json["refresh_token"],
      username: json['data']['username'],
      email: json['data']['email'],
      role: json['data']['role'],
      avatar: avatarUrl,
    );
  }


}
ResultLogin resultLoginFromJson(String str)  => ResultLogin.fromJson(json.decode(str));