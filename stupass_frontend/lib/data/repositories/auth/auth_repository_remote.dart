import '../../services/auth_api_client.dart';
import '../../services/api/model/register_request/register_request.dart';
import 'auth_repository.dart';

class AuthRepositoryRemote implements AuthRepository {
  final AuthApiClient _authApiClient;

  AuthRepositoryRemote({required AuthApiClient authApiClient}) 
      : _authApiClient = authApiClient;

  @override
  Future<void> register({
    required String phone,
    required String password,
    required String fullName,
    required String studentId,
    required String schoolId,
  }) async {
    
    final requestDto = RegisterRequest(
      phone: phone,
      password: password,
      fullName: fullName,
      studentId: studentId,
      schoolId: schoolId,
    );

    try {
      final success = await _authApiClient.registerUser(requestDto);
      
      if (!success) {
        throw Exception('Registration failed at the server.');
      }

      // TODO
      // Success! 
      // (Future step: Save the auth token to SharedPreferences here)

    } catch (e) {
      rethrow; 
    }
  }
}