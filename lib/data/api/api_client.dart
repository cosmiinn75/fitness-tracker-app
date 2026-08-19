import 'dart:convert';
import 'dart:math';

import 'package:fitness_mvp/data/storage/token_storage.dart';
import 'package:http/http.dart' as http;

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
  }) async {
    final Map<String, String> headers = {"Content-Type": "application/json"};

    if (authenticated) {
      final String? accessToken = await tokenStorage.getAccessToken();

      if (accessToken != null) {
        headers["Authorization"] = "Bearer $accessToken";
      }
    }

    return await http.get(Uri.parse("$baseUrl$endpoint"), headers: headers);
  }

  Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? body,
    bool authenticated = true,
  }) async {
    final Map<String, String> headers = {"Content-Type": "application/json"};

    if (authenticated) {
      final String? accessToken = await tokenStorage.getAccessToken();

      if (accessToken != null) {
        headers["Authorization"] = "Bearer $accessToken";
      }
    }
    return await http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
  }
}
