abstract final class Routes {
  // --- Root & Auth ---
  static const home = '/';
  static const signin = '/signin';
  static const forgotPassword = '/forgot-password';
  static const resetPassword = '/reset-password/:token';
  
  // --- Signup Flow (Nested) ---
  static const signup = '/signup';
  
  static const emailWaitingRelative = 'email_waiting';
  static const emailWaitingName = 'email';
  static const emailWaiting = '$signup/$emailWaitingRelative'; // '/signup/verify_via_otp'
  
  static const createProfileRelative = 'create_profile';
  static const createProfileName = 'create';
  static const createProfile = '$emailWaiting/$createProfileRelative'; // '/signup/verify_via_otp/create_profile'

  // --- Main Shell Tabs ---
  static const marketplace = '/marketplace';
  static const storage = '/storage';
  static const add = '/add';
  static const chat = '/chat';
  static const settings = '/settings';
}