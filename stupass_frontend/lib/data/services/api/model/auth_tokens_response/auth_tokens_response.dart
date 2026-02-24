import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_tokens_response.freezed.dart';
part 'auth_tokens_response.g.dart';

@freezed
abstract class AuthTokensResponse with _$AuthTokensResponse {
  const factory AuthTokensResponse({
    @JsonKey(name: 'access_token')
    required String accessToken,

    @JsonKey(name: 'refresh_token')
    required String refreshToken,
  }) = _AuthTokensResponse;

  factory AuthTokensResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensResponseFromJson(json);
}