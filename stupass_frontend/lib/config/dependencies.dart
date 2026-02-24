import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:stupass_frontend/data/repositories/auth/auth_repository.dart';
import 'package:stupass_frontend/data/repositories/auth/auth_repository_remote.dart';
import 'package:stupass_frontend/data/services/api/api_client.dart';
import 'package:stupass_frontend/data/services/api/auth_api_client.dart';
import 'package:stupass_frontend/data/services/shared_preferences_service.dart';
import 'package:stupass_frontend/ui/features/auth/view_models/signnup_view_model/registration_session.dart';

List<SingleChildWidget> get providersRemote {
  return [
    Provider(create: (context) => AuthApiClient()),  
    Provider(create: (context) => RegistrationSession()),
    Provider(create: (context) => ApiClient()),
    Provider(create: (context) => SharedPreferencesService()),
    ChangeNotifierProvider(
      create: (context) => AuthRepositoryRemote(
        authApiClient: context.read<AuthApiClient>(),
        sharedPreferencesService: context.read<SharedPreferencesService>(),
        apiClient: context.read<ApiClient>(),
      ) as AuthRepository, 
    ),
  ];
}