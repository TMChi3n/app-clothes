import 'dart:convert';
import 'package:clothes_app/models/user/update_profile.dart';
import 'package:clothes_app/services/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user/user_profile.dart';

class UserServices {
  static var client = http.Client();

  Future<bool> updateProfile(UpProReq updatemodel) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    final userId = shared.getString('user_id');
    final accessToken = shared.getString('access_token');
    Map<String, String> requestHeader = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    debugPrint('User có id yêu cầu update tại UserService: $userId');
    var url = Uri.http(Config.apiLocalhost, '${Config.updateProfileUser}$userId');

    try {
      var response = await client.patch(
        url,
        headers: requestHeader,
        body: jsonEncode(updatemodel.toJson()),
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint('Failed to update profile: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Lỗi khi yêu cầu update tại userService: $e');
      return false;
    }
  }

  Future<bool> getProfile() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    final accessToken = shared.getString('access_token');
    final userId = shared.getString('user_id');


    // In ra các biến trước khi gán
    print('Access Token: $accessToken');
    print('User ID: $userId');

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    var url = Uri.http(Config.apiLocalhost, '${Config.getProfileUser}$userId');

    try {
      var response = await client.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        UserProfile profile = UserProfile.fromJson(jsonResponse);
         print("ressponse :$jsonResponse");
        // Kiểm tra và xử lý các trường hợp thiếu dữ liệu
        String username = profile.username ?? 'Tên';
        String birthday = profile.birthday ?? '';
        int phoneNumber = profile.phoneNumber ?? 0;
        String gender = profile.gender ?? '';
        String address = profile.address ?? '';

        // In ra các giá trị trước khi lưu vào SharedPreferences
        print('Username: $username');
        print('Birthday: $birthday');
        print('Phone Number: $phoneNumber');
        print('Gender: $gender');
        print('Address: $address');

        // Lưu thông tin vào SharedPreferences
        shared.setString('username', username);
        shared.setString('birthday', birthday);
        shared.setInt('phone_number', phoneNumber);
        shared.setString('gender', gender);
        shared.setString('address', address);
        return true;
      } else {
        print('Lỗi khi lấy profile: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Lỗi Loading profile: $e');
      return false;
    }
  }

}
