import 'package:flutter/foundation.dart';

abstract class AuthRepository extends ChangeNotifier {
  Future<bool> get isAuthenticated;

  Future<String> register({
    required String username,
    required String identifier,
    required String password,
    required String fullName,
    required String studentId,
    required String schoolId,
  });

  Future<void> login({
    required String identifier,
    required String password,
  });

  Future<bool> handleTokenRefresh();

  Future<void> logout();

  Future<bool> checkVerificationStatus({required String identifier});

  Future<void> resendVerificationEmail({required String identifier});

  Future<void> forgotPassword({required String email});

  Future<void> resetPassword({required String token, required String newPassword});
}