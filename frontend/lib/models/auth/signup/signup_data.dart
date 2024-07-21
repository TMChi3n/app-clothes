import "dart:convert";



class SignUpModel {
  final String username;
  final String email;
  final String password;
  SignUpModel({
   required this.username,
   required this.email,
   required this.password
});

   // from Json
  factory SignUpModel.fromJson(Map<String ,dynamic> json) => SignUpModel(
   username : json['username'],
   email : json['email'],
    password: json['password'],
  );

  // to Json
  Map<String ,dynamic> toJson() =>{
    'username' : username,
    'email' : email,
    'password' : password,
  };

}
SignUpModel sinUpModelFromJson(String str)  => SignUpModel.fromJson(jsonDecode(str));
String signUpModelToJson(SignUpModel dataUser) => json.encode(dataUser.toJson());