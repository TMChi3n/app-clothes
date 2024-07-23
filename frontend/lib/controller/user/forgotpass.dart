
import 'package:flutter/material.dart';
import '../../models/user/forgotpass.dart';
import '../../services/user/securityservice/passservice.dart';

class ForgotNotifier extends ChangeNotifier {
  final PassService _authService = PassService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> sendForgotPasswordRequest(String email) async {
    isLoading = true;
    bool success = await _authService.sendForgotPassRequest(ForgotPassRequest(email: email));
    isLoading = false;
    return success;
  }
}
