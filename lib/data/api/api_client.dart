import 'dart:convert';

import 'package:fitness_mvp/data/storage/token_storage.dart';
import 'package:http/http.dart' as http;

import '../model/auth_models/auth_response.dart';
import '../model/auth_models/refresh_request.dart';

class ApiClient {
  final String baseUrl;
  final TokenStorage tokenStorage;
  final http.Client client;

  ApiClient({
    required this.baseUrl,
    required this.tokenStorage,
    required this.client,
  });



  Future<http.Response> get(
    String endpoint, {
    bool authenticated = true,
        bool retryAllowed = true
  }) async {
    final Map<String, String> headers = {"Content-Type": "application/json"};


    if (authenticated) {
      final String? accessToken = await tokenStorage.getAccessToken();

      if (accessToken != null) {
        headers["Authorization"] = "Bearer $accessToken";
      }

      final response = await client.get(Uri.parse("$baseUrl$endpoint"), headers: headers);

      if(response.statusCode == 401 && retryAllowed){
        final error = await refresh();

        if(error == null){
          return get(endpoint,authenticated: authenticated,retryAllowed: false);
        }
      }



      return response;
    }
    return await client.get(Uri.parse("$baseUrl$endpoint"),headers: headers);
  }

  Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? body,
    bool authenticated = true,
    bool retryAllowed = true
  }) async {
    final Map<String, String> headers = {"Content-Type": "application/json"};

    if (authenticated) {
      final String? accessToken = await tokenStorage.getAccessToken();

      if (accessToken != null) {
        headers["Authorization"] = "Bearer $accessToken";
      }

      final response = await client.post(
        Uri.parse("$baseUrl$endpoint"),
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      );

      if(response.statusCode == 401 && retryAllowed){
        final error = await refresh();

        if(error == null){
            return post(endpoint,body: body,authenticated: authenticated,retryAllowed: false);
        }

      }
      return response;
    }

    return await client.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  Future<String?> refresh() async{
    try{
      final Map<String, String> headers = {"Content-Type": "application/json"};
      final refreshToken = await tokenStorage.getRefreshToken();

      if(refreshToken == null){
        return  "No refresh token available";
      }

      final request = RefreshRequest(refreshToken: refreshToken);

      final response = await  client.post(Uri.parse("$baseUrl/auth/refresh"), body:jsonEncode(request.toJson()) , headers: headers );

      if(response.statusCode == 200){
        final Map<String,dynamic> json = jsonDecode(response.body);

        AuthResponse authResponse = AuthResponse.fromJson(json);

        await tokenStorage.saveTokens(authResponse.accessToken, authResponse.refreshToken);
        return null;
      }
      final Map<String,dynamic> errorJson = jsonDecode(response.body);

      return errorJson["detail"] ?? errorJson["title"] ?? "Refresh failed.";
    } catch(e){
      return "Could not connect to the server.";
    }
  }


  Future<http.Response> delete(
      String endpoint, {
        bool authenticated = true,
        bool retryAllowed = true
      }) async {
    final Map<String, String> headers = {"Content-Type": "application/json"};

    if (authenticated) {
      final String? accessToken = await tokenStorage.getAccessToken();

      if (accessToken != null) {
        headers["Authorization"] = "Bearer $accessToken";
      }

      final response = await client.delete(
        Uri.parse("$baseUrl$endpoint"),
        headers: headers,
      );

      if(response.statusCode == 401 && retryAllowed){
        final error = await refresh();

        if(error == null){
          return delete(endpoint,authenticated: authenticated,retryAllowed: false);
        }

      }
      return response;
    }

    return await client.delete(
      Uri.parse("$baseUrl$endpoint"),
      headers: headers,
    );
  }
}
