import 'dart:async';

import 'package:fitness_mvp/data/model/auth_models/login_request.dart';
import 'package:fitness_mvp/data/model/auth_models/register_request.dart';
import 'package:fitness_mvp/data/repository/auth_repository.dart';

class AuthController {
  final AuthRepository authRepository;

  AuthController({required this.authRepository});

  Future<String?> login(String username , String password) async{

    LoginRequest request = LoginRequest(username: username, password: password);

    return await authRepository.login(request);

  }


  Future<String?> register(String email,String username , String password) async{

    RegisterRequest request = RegisterRequest(email: email,username: username, password: password);


    return await authRepository.register(request);

  }

  Future<String?> refresh() async{
    return await authRepository.refresh();
  }
}