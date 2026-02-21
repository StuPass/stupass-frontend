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

  Future<void> completeRegistration(String name, String studentId, String schoolId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final phone = _registrationSession.phone!;
      final password = _registrationSession.password!;

      await _authRepository.register(
        phone: phone,
        password: password,
        fullName: name,
        studentId: studentId,
        schoolId: schoolId,
      );

      _isSuccess = true;
      _registrationSession.clear();
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