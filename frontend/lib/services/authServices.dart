import "dart:convert";

import "package:clothes_app/models/auth/signup/signup_data.dart";
import "package:clothes_app/services/config.dart";
import "package:http/http.dart " as http;
import "package:shared_preferences/shared_preferences.dart";

import "../models/auth/login/login_request.dart";
import "../models/auth/login/login_response.dart";

class AuthServices {
  static var client = http.Client();

  Future<bool> login(LoginModel userlogin) async{
    Map<String, String> requestsHeader = {"Content-Type ":"application/json"};
    var url = Uri.http(Config.apiLocalhost,Config.login_Url);

    var response = await client.post(url,headers:requestsHeader ,body:jsonEncode(userlogin.toJson()));

    if(response.statusCode == 200){
        final  SharedPreferences sharepre = await SharedPreferences.getInstance();
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
        //
        await sharepre.setBool("Logged", true);
    return true;

    }
    else{
      return false;
    }

  }
  Future<bool>  signup(SignUpModel signUpmodel) async{
    Map<String , String> requestHeader = {'Content-Type':'application/json'};
    var url = Uri.http(Config.apiLocalhost,Config.register_Url);

    var response = await client.post(url,headers: requestHeader,body: jsonEncode(signUpmodel.toJson()));
  if(response.statusCode == 200){
    return true;
  }
  else{
    return false;
  }
  }

}