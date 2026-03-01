import 'package:flutter/material.dart';
import 'package:stupass_frontend/data/repositories/auth/auth_repository.dart';
import 'package:stupass_frontend/ui/features/auth/view_models/signnup_view_model/registration_session.dart';

class CreateProfileViewModel extends ChangeNotifier {
  final RegistrationSession _registrationSession;
  final AuthRepository _authRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  CreateProfileViewModel({required RegistrationSession registrationSession, required AuthRepository authRepository})
    : _registrationSession = registrationSession, 
      _authRepository = authRepository;

  Future<void> completeRegistration(String username, String fullName, String studentId, String schoolId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _registrationSession.userId = await _authRepository.register(
        username: username,
        identifier: _registrationSession.identifier!,
        password: _registrationSession.password!,
        fullName: fullName,
        studentId: studentId,
        schoolId: schoolId,
      );

      _isSuccess = true;
    } catch (e) {
      _isSuccess = false;
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void cancelRegistration() {
    _registrationSession.clear();
  }
}