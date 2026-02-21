abstract final class Routes {
  // --- Root & Auth ---
  static const home = '/';
  static const signin = '/signin';
  
  // --- Signup Flow (Nested) ---
  static const signup = '/signup';
  
  static const verifyOtpRelative = 'verify_via_otp';
  static const verifyOtpName = 'verify';
  static const verifyOtp = '$signup/$verifyOtpRelative'; // '/signup/verify_via_otp'
  
  static const createProfileRelative = 'create_profile';
  static const createProfileName = 'create';
  static const createProfile = '$verifyOtp/$createProfileRelative'; // '/signup/verify_via_otp/create_profile'

  // --- Main Shell Tabs ---
  static const marketplace = '/marketplace';
  static const storage = '/storage';
  static const add = '/add';
  static const chat = '/chat';
  static const settings = '/settings';
}