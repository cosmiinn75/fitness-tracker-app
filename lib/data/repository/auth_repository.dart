import 'dart:convert';

import '../api/api_client.dart';
import '../model/auth_models/auth_response.dart';
import '../model/auth_models/login_request.dart';
import '../model/auth_models/register_request.dart';
import '../storage/token_storage.dart';

class AuthRepository {
  final ApiClient apiClient;
  final TokenStorage tokenStorage;

  AuthRepository({
    required this.apiClient,
    required this.tokenStorage,
  });

  Future<String?> login(LoginRequest request) async {
    try {
      final response = await apiClient.post(
        "/auth/login",
        body: request.toJson(),
        authenticated: false,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json =
        jsonDecode(response.body);

        final AuthResponse authResponse =
        AuthResponse.fromJson(json);

        await tokenStorage.saveTokens(
          authResponse.accessToken,
          authResponse.refreshToken,
        );

        return null;
      }

      final Map<String, dynamic> errorJson =
      jsonDecode(response.body);

      return errorJson["detail"] ??
          errorJson["title"] ??
          "Login failed.";
    } catch (e) {
      return "Could not connect to the server.";
    }
  }

  Future<String?> register(RegisterRequest request) async {
    try {
      final response = await apiClient.post(
        "/auth/register",
        body: request.toJson(),
        authenticated: false,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json =
        jsonDecode(response.body);

        final AuthResponse authResponse =
        AuthResponse.fromJson(json);

        await tokenStorage.saveTokens(
          authResponse.accessToken,
          authResponse.refreshToken,
        );

        return null;
      }

      final Map<String, dynamic> errorJson =
      jsonDecode(response.body);

      return errorJson["detail"] ??
          errorJson["title"] ??
          "Registration failed.";
    } catch (e) {
      return "Could not connect to the server.";
    }
  }
}