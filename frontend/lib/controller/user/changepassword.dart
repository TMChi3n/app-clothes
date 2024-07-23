// lib/controllers/change_password.dart
import 'package:flutter/material.dart';
import 'package:clothes_app/services/user/securityservice/passservice.dart'; // Update import if necessary
import '../../models/user/changepassword.dart';

class ChangePasswordNotifier extends ChangeNotifier {
  final PassService _passService = PassService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> changePassword(
      String email, String currentPassword, String newPassword) async {
    isLoading = true;
    bool success = await _passService.changePassword(ChangePasswordRequest(
      email: email,
      currentPassword: currentPassword,
      newPassword: newPassword,
    ));
    isLoading = false;
    return success;
  }
}
