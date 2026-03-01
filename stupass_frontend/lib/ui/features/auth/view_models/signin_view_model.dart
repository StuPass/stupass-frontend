import 'package:flutter/foundation.dart';
import 'package:stupass_frontend/data/repositories/auth/auth_repository.dart';

class SigninViewModel extends ChangeNotifier{
  final AuthRepository _authRepository;

  SigninViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> submitLogin(String identifier, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authRepository.login(identifier: identifier, password: password);
      
      _isSuccess = true;
    } catch (e) {
      _errorMessage = e.toString();
      _isSuccess = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}