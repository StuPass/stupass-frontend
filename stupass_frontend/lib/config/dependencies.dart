import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:stupass_frontend/data/repositories/auth/auth_repository.dart';
import 'package:stupass_frontend/data/repositories/auth/auth_repository_remote.dart';
import 'package:stupass_frontend/data/services/auth_api_client.dart';
import 'package:stupass_frontend/ui/features/auth/view_models/signnup_view_model/registration_session.dart';

List<SingleChildWidget> get providersRemote {
  return [
    Provider(create: (context) => AuthApiClient()),  
    Provider(create: (context) => RegistrationSession()),
    Provider(create: (context) => 
      AuthRepositoryRemote(
        authApiClient: context.read(),
      ) as AuthRepository
    ),
  ];
}