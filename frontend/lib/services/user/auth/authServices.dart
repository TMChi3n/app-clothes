import 'dart:convert';

import 'package:clothes_app/models/auth/login/token_service.dart';
import 'package:clothes_app/models/auth/signup/signup_data.dart';
import 'package:clothes_app/services/config.dart';
import 'package:clothes_app/services/user/getdatauser.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/auth/login/login_request.dart';
import '../../../models/auth/login/login_response.dart';

class AuthServices {
  static var client = http.Client();
  final dataUser = LoadDataUser();
  final tokenService = TokenService();

  Future<bool> login(LoginModel userlogin) async {
    Map<String, String> requestsHeader = {"Content-Type": "application/json"};
    var url = Uri.http(Config.apiLocalhost, Config.loginUrl);
    try {
      var response = await client.post(url,
          headers: requestsHeader, body: jsonEncode(userlogin.toJson()));
      if (response.statusCode == 201) {
        final SharedPreferences sharepre =
            await SharedPreferences.getInstance();
        //Đọc response chuyển đổi thành 1 ResultLogin với đầy đủ thông tin người đăng nhập
        ResultLogin resultLogin = resultLoginFromJson(response.body);
        String accessToken = resultLogin.accessToken;
        String refreshToken = resultLogin.refreshToken;
        String username = resultLogin.username;
        String email = resultLogin.email;
        String role = resultLogin.role;
        String avatar2 = resultLogin.avatar;
        // Lưu data người dùng và SharedPreferences
        await sharepre.setString('access_token', accessToken);
        await sharepre.setString('refresh_token', refreshToken);
        await sharepre.setString('username', username);
        await sharepre.setString('role', role);
        await sharepre.setBool("Logged", true);
        await sharepre.setString("avatar", avatar2);
        await tokenService.SaveIdFromToken(accessToken);
        return true;
      } else {
        // Handle specific error codes or response bodies here if needed
        return false;
      }
    } catch (e) {
      // Handle network errors, timeouts, or unexpected exceptions
      print('Login lỗi tại authService: $e');
      return false;
    }
  }

  Future<bool> signup(SignUpModel signUpmodel) async {
    Map<String, String> requestHeader = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiLocalhost, Config.registerUrl);

    try {
      var response = await client.post(url,
          headers: requestHeader, body: jsonEncode(signUpmodel.toJson()));

      print(
          'Status code, tại file authServices : ${response.statusCode}'); // In ra mã trạng thái
      if (response.statusCode == 201) {
        return true;
      } else {
        // Handle specific error codes or response bodies here if needed
        print(
            'Đăng ký thất bại tại file authService : ${response.body}'); // In ra phản hồi từ server để debug
        return false;
      }
    } catch (e) {
      // Handle network errors, timeouts, or unexpected exceptions
      print('Signup error tại file authServices : $e');
      return false;
    }
  }
}
