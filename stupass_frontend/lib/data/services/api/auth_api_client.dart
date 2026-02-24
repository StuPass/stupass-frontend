import 'dart:convert';
import 'dart:io';
import 'package:logging/logging.dart';
import 'package:stupass_frontend/data/services/api/model/auth_tokens_response/auth_tokens_response.dart';
import 'package:stupass_frontend/data/services/api/model/login_request/login_request.dart';
import 'package:stupass_frontend/data/services/api/model/logout_request/logout_request.dart';
import 'package:stupass_frontend/data/services/api/model/refresh_request/refresh_request.dart';

import 'model/register_request/register_request.dart'; 

class AuthApiClient {
  AuthApiClient({String? host, int? port, HttpClient Function()? clientFactory})
    : _host = host ?? 'tavernless-daina-dedicatedly.ngrok-free.dev', // TODO: Change this into .env file soon!
      _port = port ?? 443,
      _clientFactory = clientFactory ?? HttpClient.new;

  final String _host;
  final int _port;
  final HttpClient Function() _clientFactory;
  final _log = Logger('AuthApiClient');

  /// Sends a registration request to the Rust backend.
  /// Returns true if successful, throws an Exception if it fails.
  Future<bool> registerUser(RegisterRequest payload) async {
    final client = _clientFactory();

    try {
      final uri = Uri(
        scheme: _port == 443 ? 'https' : 'http',
        host: _host,
        port: (_port == 443 || _port == 80) ? null : _port, 
        path: '/auth/register',
      );

      final request = await client.postUrl(uri);      
      
      request.headers.add('ngrok-skip-browser-warning', 'true');
      request.headers.contentType = ContentType.json;
      
      request.write(jsonEncode(payload));

      final response = await request.close()  ;

      final stringData = await response.transform(utf8.decoder).join();
      if (response.statusCode == 200 || response.statusCode == 201) {
        _log.info('User registered successfully');
        return true;
      } else {
        _log.severe('Registration failed: $stringData');
        throw Exception('Failed to register: ${response.statusCode}');
      }
    } catch (e) {
      _log.warning('Network error during registration: $e');
      throw Exception('Network error: $e');
    } finally {
      client.close();
    }
  }

  // ---------------------------------------------------------
  // LOGIN
  // ---------------------------------------------------------
  Future<AuthTokensResponse> login(LoginRequest payload) async {
    final client = _clientFactory();
    try {
      final uri = Uri(
        scheme: _port == 443 ? 'https' : 'http',
        host: _host,
        port: (_port == 443 || _port == 80) ? null : _port, 
        path: '/auth/login',
      );

      final request = await client.postUrl(uri);      

      request.headers.add('ngrok-skip-browser-warning', 'true');
      request.headers.contentType = ContentType.json;
      
      request.write(jsonEncode(payload));
      
      final response = await request.close();

      final stringData = await response.transform(utf8.decoder).join();
      if (response.statusCode == 200) {
        return AuthTokensResponse.fromJson(jsonDecode(stringData));
      } else {
        _log.severe('Login failed: $stringData');
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      _log.warning('Network error during login: $e');
      throw Exception('Network error: $e');
    } finally {
      client.close();
    }
  }

  // ---------------------------------------------------------
  // REFRESH TOKEN
  // ---------------------------------------------------------
  Future<AuthTokensResponse> refreshToken(RefreshRequest payload) async {
    final client = _clientFactory();
    try {
      final uri = Uri(
        scheme: _port == 443 ? 'https' : 'http',
        host: _host,
        port: (_port == 443 || _port == 80) ? null : _port, 
        path: '/auth/refresh',
      );

      final request = await client.postUrl(uri);      
      
      request.headers.add('ngrok-skip-browser-warning', 'true');
      request.headers.contentType = ContentType.json;
      
      request.write(jsonEncode(payload));
      
      final response = await request.close();
      
      final stringData = await response.transform(utf8.decoder).join();
      if (response.statusCode == 200) {
        return AuthTokensResponse.fromJson(jsonDecode(stringData));
      } else {
        throw Exception('The refresh token is invalid or expired');
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      client.close();
    }
  }

  // ---------------------------------------------------------
  // LOGOUT
  // ---------------------------------------------------------
  Future<void> logout(LogoutRequest payload) async {
    final client = _clientFactory();
    try {
      final uri = Uri(
        scheme: _port == 443 ? 'https' : 'http',
        host: _host,
        port: (_port == 443 || _port == 80) ? null : _port,
        path: '/auth/logout',
      );

      final request = await client.postUrl(uri);
      
      request.headers.add('ngrok-skip-browser-warning', 'true');
      request.headers.contentType = ContentType.json;
      
      request.write(jsonEncode(payload));
      
      final response = await request.close();
      
      if (response.statusCode != 200 && response.statusCode != 204) {
        final stringData = await response.transform(utf8.decoder).join();
        _log.severe('Server rejected logout: $stringData');
        throw Exception('Failed to logout from server: ${response.statusCode}');
      }
    } catch (e) {
      _log.warning('Network error during logout: $e');
      throw Exception('Network error: $e');
    } finally {
      client.close();
    }
  }
}