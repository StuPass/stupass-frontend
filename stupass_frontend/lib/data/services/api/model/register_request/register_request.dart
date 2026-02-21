import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.freezed.dart';
part 'register_request.g.dart';

@freezed
abstract class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String phone,

    required String password,

    @JsonKey(name: 'full_name') 
    required String fullName,

    @JsonKey(name: 'student_id') 
    required String studentId,

    @JsonKey(name: 'school_id') 
    required String schoolId,

  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}