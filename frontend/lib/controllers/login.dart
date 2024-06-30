import 'package:clothes_app/models/auth/login/login_request.dart';
import 'package:clothes_app/services/authServices.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends ChangeNotifier{
  bool _isObsecure = false;
  bool get isObsecure => _isObsecure;

  // ẩn hiện mật khẩu
  set isObsecure(bool newState){
    _isObsecure = newState;
    notifyListeners();
  }

  //
  bool _processing = false;
  bool get processing => _processing;
  set processing(bool newState){
    _processing = newState;
    notifyListeners();
  }

  // login response
  bool _login = false;
  bool get login => _login;
  set login(bool newState){
    _login = newState;
    notifyListeners();
  }
  bool _responseBool = false;
  bool get responseBool => _responseBool;
  set responseBool(bool newState){
    _responseBool = newState;
    notifyListeners();
  }
  // check ng đã đăng nhập chưa
  bool? _logged ;
  bool get logged => _logged??false;
  set logged(bool newSate){
    _logged = newSate;
    notifyListeners();

  }
  //
  Future<bool> userLogin(LoginModel model) async {
    final SharedPreferences sharedpre = await SharedPreferences.getInstance();
    processing = false;

    bool response = await AuthServices().login(model);
    login = response;
    logged = sharedpre.getBool('Logged') ?? false;
    return login;
  }
  //đăng xuất
  LogOut() async{
    final SharedPreferences sharedpre = await SharedPreferences.getInstance();
    sharedpre.remove('access_token');
    sharedpre.remove('refresh_token');
    sharedpre.remove('username');
    sharedpre.remove('email');
    sharedpre.remove('role');
    sharedpre.remove('Logged');
    logged = sharedpre.getBool('Logged') ?? false;
  }
}