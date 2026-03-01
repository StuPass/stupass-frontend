import 'package:logging/logging.dart';
import 'package:stupass_frontend/data/services/api/api_client.dart';
import 'package:stupass_frontend/data/services/api/model/login_request/login_request.dart';
import 'package:stupass_frontend/data/services/api/model/logout_request/logout_request.dart';
import 'package:stupass_frontend/data/services/api/model/refresh_request/refresh_request.dart';
import 'package:stupass_frontend/data/services/api/model/resend_verification_request/resend_verification_request.dart';
import 'package:stupass_frontend/data/services/api/model/forgot_password_request/forgot_password_request.dart';
import 'package:stupass_frontend/data/services/api/model/reset_password_request/reset_password_request.dart';
import 'package:stupass_frontend/data/services/shared_preferences_service.dart';

import '../../services/api/auth_api_client.dart';
import '../../services/api/model/register_request/register_request.dart';
import 'auth_repository.dart';

class AuthRepositoryRemote extends AuthRepository {
  final AuthApiClient _authApiClient;
  final ApiClient _apiClient;
  final SharedPreferencesService _sharedPreferencesService;

  AuthRepositoryRemote({
    required AuthApiClient authApiClient,
    required SharedPreferencesService sharedPreferencesService,
    required ApiClient apiClient,
  }) 
      : _authApiClient = authApiClient,
        _sharedPreferencesService = sharedPreferencesService,
        _apiClient = apiClient {
    _apiClient.authHeaderProvider = _authHeaderProvider;
  }

  bool? _isAuthenticated;
  String? _accessToken;
  String? _refreshToken;
  final _log = Logger('AuthRepositoryRemote');

  String? _authHeaderProvider() =>
        _accessToken != null ? 'Bearer $_accessToken' : null;

  // ---------------------------------------------------------
  // INITIALIZATION
  // ---------------------------------------------------------

  Future<void> _fetch() async {
    try {
      _accessToken = await _sharedPreferencesService.fetchAccessToken();
      _refreshToken = await _sharedPreferencesService.fetchRefreshToken();
      
      _isAuthenticated = _refreshToken != null;
    } catch (e) {
      _log.severe('Failed to fetch tokens from SharedPreferences: $e');
      _isAuthenticated = false;
    }
  }

  @override
  Future<bool> get isAuthenticated async {
    if (_isAuthenticated != null) return _isAuthenticated!;
    await _fetch();
    return _isAuthenticated ?? false;
  }

  // ---------------------------------------------------------
  // REGISTER
  // ---------------------------------------------------------

  @override
  Future<String> register({
    required String username,
    required String identifier,
    required String password,
    required String fullName,
    required String studentId,
    required String schoolId,
  }) async {
    
    final requestDto = RegisterRequest(
      email: identifier,
      password: password,
      username: username,
      fullName: fullName,
      studentId: studentId,
      schoolId: schoolId,
    );

    try {
      final userId = await _authApiClient.registerUser(requestDto);
      
      return userId;    
    } catch (e) {
      _log.warning('Registration failed at the server: $e');
      rethrow; 
    }
  }
  
  // ---------------------------------------------------------
  // LOGIN
  // ---------------------------------------------------------
  
  @override
  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    try {
      final payload = LoginRequest(identifier: identifier, password: password);
      
      // Call the API (Will throw if Rust rejects it)
      final tokens = await _authApiClient.login(payload);
      
      _log.info('User logged in successfully');
      
      _isAuthenticated = true;
      _accessToken = tokens.accessToken;
      _refreshToken = tokens.refreshToken;

      // Save to disk
      await _sharedPreferencesService.saveAccessToken(_accessToken);
      await _sharedPreferencesService.saveRefreshToken(_refreshToken);

    } catch (e) {
      _log.warning('Error logging in: $e');
      rethrow; 
    } finally {
      notifyListeners();
    }
  }

  // ---------------------------------------------------------
  // REFRESH INTERCEPTOR LOGIC
  // ---------------------------------------------------------
  @override
  Future<bool> handleTokenRefresh() async {
    _log.info('Attempting to refresh access token...');
    
    if (_refreshToken == null) {
      _log.warning('No refresh token. Forcing logout.');
      await logout();
      return false;
    }

    try {
      final payload = RefreshRequest(refreshToken: _refreshToken!);
      
      // Call the API (Will throw if Rust rejects the refresh token)
      final tokens = await _authApiClient.refreshToken(payload);
      
      _log.info('Tokens refreshed successfully');
      
      _accessToken = tokens.accessToken;
      _refreshToken = tokens.refreshToken;
      
      await _sharedPreferencesService.saveAccessToken(_accessToken);
      await _sharedPreferencesService.saveRefreshToken(_refreshToken);
      
      return true;
      
    } catch (e) {
      _log.severe('Refresh failed or rejected. Session is dead. $e');
      await logout();
      return false;
    }
  }

  // ---------------------------------------------------------
  // LOGOUT
  // ---------------------------------------------------------
  @override
  Future<void> logout() async {
    _log.info('Initiating logout sequence...');
    
    try {
      if (_refreshToken != null) {
        final payload = LogoutRequest(refreshToken: _refreshToken!);
        await _authApiClient.logout(payload);
        _log.info('Server session successfully destroyed.');
      }
    } catch (e) {
      _log.warning('Server logout failed, proceeding to clear local state: $e');
    } finally {
      await _sharedPreferencesService.saveAccessToken(null);
      await _sharedPreferencesService.saveRefreshToken(null);

      _accessToken = null;
      _refreshToken = null;
      _isAuthenticated = false;
      
      notifyListeners();
    }
  }

  // ---------------------------------------------------------
  // SHORT POLLING VERIFICATION
  // ---------------------------------------------------------
  @override
  Future<bool> checkVerificationStatus({required String identifier}) async {
    try {
      return await _authApiClient.checkVerificationStatus(identifier);
    } catch (e) {
      _log.warning('Polling hiccup while checking status: $e');
      return false; 
    }  
  }

  @override
  Future<void> resendVerificationEmail({required String identifier}) async {
    try {
      final requestDto = ResendVerificationRequest(
        email: identifier,
      );
      await _authApiClient.resendVerificationEmail(requestDto);
    } catch (e) {
      _log.warning('Resending verification failed at the server: $e');
      rethrow; 
    }  
  }

  // ---------------------------------------------------------
  // FORGOT PASSWORD
  // ---------------------------------------------------------
  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      final requestDto = ForgotPasswordRequest(email: email);
      await _authApiClient.forgotPassword(requestDto);
    } catch (e) {
      _log.warning('Forgot password request failed at the server: $e');
      rethrow;
    }
  }

  // ---------------------------------------------------------
  // RESET PASSWORD
  // ---------------------------------------------------------
  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      final requestDto = ResetPasswordRequest(
        token: token,
        newPassword: newPassword,
      );
      await _authApiClient.resetPassword(requestDto);
    } catch (e) {
      _log.warning('Reset password request failed at the server: $e');
      rethrow;
    }
  }
}