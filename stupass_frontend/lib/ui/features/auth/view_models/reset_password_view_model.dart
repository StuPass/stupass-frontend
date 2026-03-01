import 'package:flutter/foundation.dart';
import 'package:stupass_frontend/data/repositories/auth/auth_repository.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  ResetPasswordViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> submitResetPassword(String token, String newPassword) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authRepository.resetPassword(
        token: token,
        newPassword: newPassword,
      );
      
      _isSuccess = true;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _isSuccess = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
