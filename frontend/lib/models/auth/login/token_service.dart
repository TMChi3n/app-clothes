import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  Future<void> SaveIdFromToken(String token) async{
     Map<String,dynamic> payload = JwtDecoder.decode(token);
     if(payload.containsKey("sub")){
       int userId = payload['sub'];

       final SharedPreferences shared = await SharedPreferences.getInstance();
       await shared.setString('user_id', userId.toString());
       print('User ID đã lưu trong SharedPreferences: $userId');
     } else {
       print('Token không chứa user ID');
     }
  }
}
//qua copy code ben kia
