import 'dart:convert';
import 'dart:io';
import 'package:logging/logging.dart';
import 'package:stupass_frontend/data/services/api/model/auth_tokens_response/auth_tokens_response.dart';
import 'package:stupass_frontend/data/services/api/model/login_request/login_request.dart';
import 'package:stupass_frontend/data/services/api/model/logout_request/logout_request.dart';
import 'package:stupass_frontend/data/services/api/model/refresh_request/refresh_request.dart';
import 'package:stupass_frontend/data/services/api/model/resend_verification_request/resend_verification_request.dart';
import 'package:stupass_frontend/data/services/api/model/forgot_password_request/forgot_password_request.dart';
import 'package:stupass_frontend/data/services/api/model/reset_password_request/reset_password_request.dart';

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
  Future<String> registerUser(RegisterRequest payload) async {
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

      final response = await request.close();

      final stringData = await response.transform(utf8.decoder).join();
      if (response.statusCode == 200 || response.statusCode == 201) {
        _log.info('User registered successfully');

        final Map<String, dynamic> jsonResponse = jsonDecode(stringData);
        
        if (!jsonResponse.containsKey('user_id')) {
           throw Exception('Backend did not return a user ID');
        }

        return jsonResponse['user_id'].toString();
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
      if (response.statusCode == 200 || response.statusCode == 201) {
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
      if (response.statusCode == 200 || response.statusCode == 201) {
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

  // ---------------------------------------------------------
  // VERIFICATION STATUS CHECK
  // ---------------------------------------------------------
  Future<bool> checkVerificationStatus(String userId) async {
    final client = _clientFactory();
    try {
      final uri = Uri(
        scheme: _port == 443 ? 'https' : 'http',
        host: _host,
        port: (_port == 443 || _port == 80) ? null : _port,
        path: '/auth/check-status/$userId',
      );

      _log.info("Final URL: $uri");

      final request = await client.getUrl(uri);
      
      request.headers.add('ngrok-skip-browser-warning', 'true');
      request.headers.add(HttpHeaders.acceptHeader, 'application/json');
      
      final response = await request.close();
      final stringData = await response.transform(utf8.decoder).join();
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(stringData);
        return json['verification_status'] == 'verified';
      } else {
        _log.severe('Server rejected status check: $stringData');
        throw Exception('Failed to check status: ${response.statusCode}');
      }
    } catch (e) {
      _log.warning('Network error during status check: $e');
      rethrow;
    } finally {
      client.close();
    }
  }

  // ---------------------------------------------------------
  // RESEND VERIFICATION EMAIL
  // ---------------------------------------------------------
  Future<void> resendVerificationEmail(ResendVerificationRequest payload) async {
    final client = _clientFactory();
    try {
      final uri = Uri(
        scheme: _port == 443 ? 'https' : 'http',
        host: _host,
        port: (_port == 443 || _port == 80) ? null : _port,
        path: '/auth/resend-verification', 
      );

      final request = await client.postUrl(uri);
      
      request.headers.add('ngrok-skip-browser-warning', 'true');
      request.headers.contentType = ContentType.json;
      
      request.write(jsonEncode(payload));
      
      final response = await request.close();
      
      if (response.statusCode != 200 && response.statusCode != 202) {
        final stringData = await response.transform(utf8.decoder).join();
        _log.severe('--- 400/422 RESEND ERROR ---');
        _log.severe('Rust says: $stringData');
        throw Exception('Failed to resend email: $stringData');
      }
    } catch (e) {
      _log.warning('Network error during email resend: $e');
      rethrow; 
    } finally {
      client.close();
    }
  }

  // ---------------------------------------------------------
  // FORGOT PASSWORD
  // ---------------------------------------------------------
  Future<void> forgotPassword(ForgotPasswordRequest payload) async {
    final client = _clientFactory();
    try {
      final uri = Uri(
        scheme: _port == 443 ? 'https' : 'http',
        host: _host,
        port: (_port == 443 || _port == 80) ? null : _port,
        path: '/auth/forgot-password',
      );

      final request = await client.postUrl(uri);
      
      request.headers.add('ngrok-skip-browser-warning', 'true');
      request.headers.contentType = ContentType.json;
      
      request.write(jsonEncode(payload));
      
      final response = await request.close();
      
      if (response.statusCode != 200 && response.statusCode != 202) {
        final stringData = await response.transform(utf8.decoder).join();
        _log.severe('Forgot password request failed: $stringData');
        throw Exception('Failed to send password reset email: $stringData');
      }
      
      _log.info('Password reset email sent successfully');
    } catch (e) {
      _log.warning('Network error during forgot password: $e');
      rethrow;
    } finally {
      client.close();
    }
  }

  // ---------------------------------------------------------
  // RESET PASSWORD
  // ---------------------------------------------------------
  Future<void> resetPassword(ResetPasswordRequest payload) async {
    final client = _clientFactory();
    try {
      final uri = Uri(
        scheme: _port == 443 ? 'https' : 'http',
        host: _host,
        port: (_port == 443 || _port == 80) ? null : _port,
        path: '/auth/reset-password',
      );

      final request = await client.postUrl(uri);
      
      request.headers.add('ngrok-skip-browser-warning', 'true');
      request.headers.contentType = ContentType.json;
      
      request.write(jsonEncode(payload));
      
      final response = await request.close();
      
      if (response.statusCode != 200 && response.statusCode != 202) {
        final stringData = await response.transform(utf8.decoder).join();
        _log.severe('Reset password request failed: $stringData');
        throw Exception('Failed to reset password: $stringData');
      }
      
      _log.info('Password reset successfully');
    } catch (e) {
      _log.warning('Network error during password reset: $e');
      rethrow;
    } finally {
      client.close();
    }
  }

}