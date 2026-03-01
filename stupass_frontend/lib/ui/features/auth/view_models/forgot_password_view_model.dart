import 'package:flutter/foundation.dart';
import 'package:stupass_frontend/data/repositories/auth/auth_repository.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  ForgotPasswordViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> submitForgotPassword(String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authRepository.forgotPassword(email: email);
      
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
