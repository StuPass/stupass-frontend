import 'package:flutter/foundation.dart';

abstract class AuthRepository extends ChangeNotifier {
  Future<bool> get isAuthenticated;

  Future<void> register({
    required String username,
    required String phone,
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
}