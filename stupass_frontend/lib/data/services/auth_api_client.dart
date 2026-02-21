import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'api/model/register_request/register_request.dart'; 

class AuthApiClient {
  // TODO: Change this into .env file soon!
  final String baseUrl = 'https://tavernless-daina-dedicatedly.ngrok-free.dev';

  /// Sends a registration request to the Rust backend.
  /// Returns true if successful, throws an Exception if it fails.
  Future<bool> registerUser(RegisterRequest request) async {
    final url = Uri.parse('$baseUrl/auth/register');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(request.toJson()), 
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('User registered successfully');
        return true;
      } else {
        debugPrint('Registration failed: ${response.body}');
        throw Exception('Failed to register: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Network error during registration: $e');
      throw Exception('Network error: $e');
    }
  }
}