class RegistrationSession {
  String? phone;
  String? password;
  String? otpCode;      
  String? fullName;     
  String? studentId;
  String? schoolId;
  String? verificationId;

  void clear() {
    phone = null;
    password = null;
    otpCode = null;
    fullName = null;
    studentId = null;
    schoolId = null;
    verificationId = null;
  }
}