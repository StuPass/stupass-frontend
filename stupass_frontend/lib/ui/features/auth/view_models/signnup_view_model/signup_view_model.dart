import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stupass_frontend/ui/features/auth/view_models/signnup_view_model/registration_session.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SignupViewModel extends ChangeNotifier {
  final RegistrationSession _registrationSession;
  
  SignupViewModel({required RegistrationSession registrationSession})
    : _registrationSession = registrationSession;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> sendFirebaseOtp(String phone, String password) async {
    try {
      _isLoading = true;

      final formattedPhone = phone.startsWith('0') 
          ? '+84${phone.substring(1)}' 
          : phone;

      _registrationSession.phone = phone;
      _registrationSession.password = password;

      if (kIsWeb) {
        try {
            ConfirmationResult confirmationResult = await FirebaseAuth.instance.signInWithPhoneNumber(formattedPhone);
            
            // Save the verificationId to your vault just like before
            _registrationSession.verificationId = confirmationResult.verificationId;
            
            _isSuccess = true;
            notifyListeners();
          } catch (e) {
            _errorMessage = "Lỗi web: ${e.toString()}";
            notifyListeners();
          }      
      } else {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: formattedPhone,
          
          verificationCompleted: (PhoneAuthCredential credential) async {
          },
          
          verificationFailed: (FirebaseAuthException e) {
            _errorMessage = e.message ?? "Lỗi gửi SMS";
            notifyListeners();
          },
          
          codeSent: (String verificationId, int? resendToken) {
            _registrationSession.verificationId = verificationId;
            _isSuccess = true;
            notifyListeners();
          },
          
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      }
    } finally {
      _isLoading = false;
    }
  }
  
  void cancelRegistration() {
    _registrationSession.clear();
  }
}