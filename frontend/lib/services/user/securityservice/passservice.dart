// lib/services/user/securityservice/passservice.dart
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:clothes_app/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/user/changepassword.dart';
import '../../../models/user/forgotpass.dart';

class PassService {
  static var client = http.Client();

  Future<bool> sendForgotPassRequest(ForgotPassRequest request) async {
    var url = Uri.http(Config.apiLocalhost, Config.forgotPassword);

    try {
      var response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint('Failed to send forgot password request: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error sending forgot password request: $e');
      return false;
    }
  }

  Future<bool> changePassword(ChangePasswordRequest request) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    final token = shared.getString('access_token');
    final userId = shared.getString('user_id');
    var url = Uri.http(Config.apiLocalhost, '${Config.changePassword}/$userId'); // Ensure the URL is correct

    try {
      var response = await client.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint('Failed to change password: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error changing password: $e');
      return false;
    }
  }
}
