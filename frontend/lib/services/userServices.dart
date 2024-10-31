import 'dart:convert';
import 'package:clothes_app/models/user/update_profile.dart';
import 'package:clothes_app/services/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
   static var client = http.Client();

   Future<bool> updateProfile(UpProReq updatemodel) async {
      Map<String, String> requestHeader = {'Content-Type': 'application/json'};
      SharedPreferences shared = await SharedPreferences.getInstance();
      final user_id = shared.getInt('user_id');

      debugPrint('User có id yêu cầu update tại UserService: $user_id');
      var url = Uri.http(Config.apiLocalhost, '${Config.updateProfileUser}$user_id');

      try {
         var response = await client.patch(
             url,
             headers: requestHeader,
             body: jsonEncode(updatemodel.toJson())
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
}
