import 'package:clothes_app/models/user/update_profile.dart';
import 'package:clothes_app/services/userServices.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{
  bool _processing = false;
  bool get processing => _processing;
  set processing(bool newstate){
    _processing = newstate;
    notifyListeners();
  }

  Future<bool> UpdateProfile(UpProReq model) async{
    processing = true;
    bool response = await UserServices().updateProfile(model);
    processing = false;
    return response;
  }
}