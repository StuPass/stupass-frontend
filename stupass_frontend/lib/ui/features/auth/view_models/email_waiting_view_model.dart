import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:stupass_frontend/data/repositories/auth/auth_repository.dart';
import 'package:stupass_frontend/ui/features/auth/view_models/signnup_view_model/registration_session.dart';

class EmailWaitingViewModel extends ChangeNotifier {
  EmailWaitingViewModel({
    required AuthRepository authRepository,
    required RegistrationSession registrationSession,
  }) : _authRepository = authRepository,
       _email = registrationSession.identifier!,
       _userId = registrationSession.userId!,
       _registrationSession = registrationSession;

  final AuthRepository _authRepository;
  final RegistrationSession _registrationSession;

  bool _isResending = false;
  bool _isVerified = false; // Tracks if the backend confirmed the email
  Timer? _pollingTimer;
  String? _errorMessage;
  final _log = Logger('EmailWaitingViewModel');
  final String _email;
  final String _userId;

  bool get isResending => _isResending;
  bool get isVerified => _isVerified;
  String? get errorMessage => _errorMessage;
  String get email => _email;
  String get userId => _userId;
  
  /// Requests a new verification email to be sent
  Future<bool> resendVerificationEmail() async {
    _isResending = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authRepository.resendVerificationEmail(identifier: email);
      
      return true; 
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      return false; 
    } finally {
      _isResending = false;
      notifyListeners();
    }
  }

  void startListeningForVerification() {
    // Cancel any existing timer just in case
    _pollingTimer?.cancel();

    // Fire a request every 3 seconds
    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      try {
        final status = await _authRepository.checkVerificationStatus(identifier: userId);
        
        if (status == true) {
          _isVerified = true;
          timer.cancel(); 
          notifyListeners();
        }
      } catch (e) {
        _log.info('Polling error: $e'); 
      }
    });
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }  

  void clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      notifyListeners();
    }
  }

  void cancelRegistration() {
    _registrationSession.clear();
  }
}