import 'dart:io';

typedef AuthHeaderProvider = String? Function();

class ApiClient {
  ApiClient({String? host, int? port, HttpClient Function()? clientFactory})
    : _host = host ?? 'localhost',
      _port = port ?? 443,
      _clientFactory = clientFactory ?? HttpClient.new;

  final String _host;
  final int _port;
  final HttpClient Function() _clientFactory;
  
  AuthHeaderProvider? _authHeaderProvider;

  set authHeaderProvider(AuthHeaderProvider authHeaderProvider) {
    _authHeaderProvider = authHeaderProvider;
  }
  
  Future<void> _authHeader(HttpHeaders headers) async {
    final header = _authHeaderProvider?.call();
    if (header != null) {
      headers.add(HttpHeaders.authorizationHeader, header);
    }
  }
}