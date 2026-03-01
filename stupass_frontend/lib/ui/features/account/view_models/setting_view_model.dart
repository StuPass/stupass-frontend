import 'package:flutter/foundation.dart';
import 'package:stupass_frontend/data/repositories/auth/auth_repository.dart';

class SettingViewModel extends ChangeNotifier {
  SettingViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository;

  final AuthRepository _authRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authRepository.logout();
      _isSuccess = true;
      _errorMessage = null;
    } catch (e) {
      _isSuccess = false;
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
