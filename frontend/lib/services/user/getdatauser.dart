import 'package:shared_preferences/shared_preferences.dart';

class LoadDataUser {
  Future<UserData> loadDataUser() async {
    try {
      final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

      String accessToken = sharedPreferences.getString('access_token') ?? '';
      String refreshToken = sharedPreferences.getString('refresh_token') ?? '';
      String username = sharedPreferences.getString('username') ?? '';
      String email = sharedPreferences.getString('email') ?? '';
      String role = sharedPreferences.getString('role') ?? '';
      String avatar = sharedPreferences.getString('avatar') ?? '';

      return UserData(
        accessToken: accessToken,
        refreshToken: refreshToken,
        username: username,
        email: email,
        role: role,
        avatar: avatar,
      );
    } catch (e) {
      print('Lỗi khi lấy thông tin người dùng: $e');
      rethrow; // Handle the error appropriately in your application
    }
  }
}

class UserData {
  final String accessToken;
  final String refreshToken;
  final String username;
  final String email;
  final String role;
  final String avatar;

  UserData({
    required this.accessToken,
    required this.refreshToken,
    required this.username,
    required this.email,
    required this.role,
    required this.avatar,
  });
}
