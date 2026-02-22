abstract class AuthRepository {
  Future<void> register({
    required String username,
    required String phone,
    required String password,
    required String fullName,
    required String studentId,
    required String schoolId,
  });
}