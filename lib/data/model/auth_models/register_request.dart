import 'dart:math';

class RegisterRequest {
  String email;
  String username;
  String password;

  RegisterRequest({required this.email, required this.username, required this.password});

  Map<String,dynamic> toJson(){
    return {
      'email':email,
      'username':username,
      'password':password
    };
  }
}