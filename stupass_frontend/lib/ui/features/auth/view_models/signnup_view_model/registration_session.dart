class RegistrationSession {
  String? username;
  String? phone;
  String? password;
  String? otpCode;      
  String? fullName;     
  String? studentId;
  String? schoolId;
  String? verificationId;

  void clear() {
    username = null;
    phone = null;
    password = null;
    otpCode = null;
    fullName = null;
    studentId = null;
    schoolId = null;
    verificationId = null;
  }
}