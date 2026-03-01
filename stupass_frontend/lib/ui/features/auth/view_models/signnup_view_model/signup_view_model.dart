import 'package:flutter/foundation.dart';
import 'package:stupass_frontend/data/repositories/auth/auth_repository.dart';
import 'package:stupass_frontend/ui/features/auth/view_models/signnup_view_model/registration_session.dart';

class SignupViewModel extends ChangeNotifier {
  final RegistrationSession _registrationSession;
  
  SignupViewModel({
    required RegistrationSession registrationSession,
    required AuthRepository authRepository  
  }) : _registrationSession = registrationSession;

  void register(String identifier, String password) {
    _registrationSession.identifier = identifier;
    _registrationSession.password = password;
  }
  
  void cancelRegistration() {
    _registrationSession.clear();
  }
}