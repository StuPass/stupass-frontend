import 'package:go_router/go_router.dart';
import 'package:stupass_frontend/features/auth/presentation/signin_page.dart';
import 'package:stupass_frontend/features/auth/presentation/welcome_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: '/signin',
      builder: (context, state) => const SigninPage(),
    ),
  ],
);