import 'dart:convert';
import 'package:clothes_app/models/auth/signup/signup_data.dart';
import 'package:clothes_app/models/auth/login/login_request.dart';
import 'package:clothes_app/models/auth/login/login_response.dart';
import 'package:clothes_app/services/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static var client = http.Client();

  Future<bool> login(LoginModel userlogin) async {
    Map<String, String> requestsHeader = {"Content-Type": "application/json"};
    var url = Uri.https(Config.apiLocalhost, Config.login_Url);

    var response = await client.post(
      url,
      headers: requestsHeader,
      body: jsonEncode(userlogin.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final SharedPreferences sharepre = await SharedPreferences.getInstance();
      ResultLogin resultLogin = resultLoginFromJson(response.body);
      String accessToken = resultLogin.accessToken;
      String refreshToken = resultLogin.refreshToken;
      String username = resultLogin.username;
      String email = resultLogin.email;
      String role = resultLogin.role;
      await sharepre.setString('access_token', accessToken);
      await sharepre.setString('refresh_token', refreshToken);
      await sharepre.setString('username', username);
      await sharepre.setString('email', email);
      await sharepre.setString('role', role);
      await sharepre.setBool("Logged", true);
      await getUser(accessToken);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signup(SignUpModel signUpmodel) async {
    Map<String, String> requestHeader = {'Content-Type': 'application/json'};
    var url = Uri.https(Config.apiLocalhost, Config.register_Url);

    var response = await client.post(
      url,
      headers: requestHeader,
      body: jsonEncode(signUpmodel.toJson()),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

   Future<void> getUser(String accessToken) async {
    final SharedPreferences sharepre = await SharedPreferences.getInstance();
    var url = Uri.https(Config.apiLocalhost, '/api/v1/users');

    try {
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final userId = jsonResponse[0]['id_user'].toString();
        await sharepre.setString('user_id', userId);
      } else {
        throw Exception('Failed to get user data');
      }
    } finally {}
  }
}
