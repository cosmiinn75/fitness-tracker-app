import 'dart:convert';

import 'package:fitness_mvp/data/DTO/user_info_response.dart';
import 'package:fitness_mvp/data/api/api_client.dart';

class UserRepository {
  final ApiClient apiClient;

  UserRepository({required this.apiClient});


  Future<UserInfoResponse> getUserInfo() async{
    final response =await apiClient.get("/users/me");

    if(response.statusCode != 200){
      throw Exception("Could not retrieve user info ${response.statusCode}");
    }

    return UserInfoResponse.fromJson(jsonDecode(response.body));
  }

}