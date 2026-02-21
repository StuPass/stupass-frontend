// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    _RegisterRequest(
      phone: json['phone'] as String,
      password: json['password'] as String,
      fullName: json['full_name'] as String,
      studentId: json['student_id'] as String,
      schoolId: json['school_id'] as String,
    );

Map<String, dynamic> _$RegisterRequestToJson(_RegisterRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'password': instance.password,
      'full_name': instance.fullName,
      'student_id': instance.studentId,
      'school_id': instance.schoolId,
    };
