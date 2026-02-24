import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:stupass_frontend/ui/features/auth/view_models/signnup_view_model/registration_session.dart';

class OtpVerificationViewModel extends ChangeNotifier {
  final RegistrationSession _registrationSession;

  OtpVerificationViewModel({required RegistrationSession registrationSession}) 
    : _registrationSession = registrationSession;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> verifyFirebaseOtp(String smsCode) async {
    _registrationSession.otpCode = smsCode;

    try {
      _isLoading = true;
      final verificationId = _registrationSession.verificationId;
      
      if (verificationId == null) throw Exception("Missing verification ID");

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      _isSuccess = true;
      notifyListeners();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        _errorMessage = "Mã OTP không chính xác."; 
      } else {
        _errorMessage = e.message;
      }
      notifyListeners();
    } finally {
      _isLoading = false;
    }
  }
  
  void cancelRegistration() {
    _registrationSession.clear();
  }
}