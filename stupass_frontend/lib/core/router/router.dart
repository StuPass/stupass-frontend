import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:stupass_frontend/features/account/presentation/setting_page.dart';
import 'package:stupass_frontend/features/auth/presentation/create_profile_page.dart';
import 'package:stupass_frontend/features/auth/presentation/signin_page.dart';
import 'package:stupass_frontend/features/auth/presentation/signup_page.dart';
import 'package:stupass_frontend/features/auth/presentation/verify_via_otp_page.dart';
import 'package:stupass_frontend/features/auth/presentation/welcome_page.dart';
import 'package:stupass_frontend/features/chat/presentation/chat_box_page.dart';
import 'package:stupass_frontend/features/home/presentation/marketplace_page.dart';
import 'package:stupass_frontend/features/storage/presentation/storage.dart';

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
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupPage(),
      routes: [
        GoRoute(
          name: 'verify',
          path: 'verify_via_otp',
          builder: (context, state) => const OtpVerificationPage(),
          routes: [
            GoRoute(
              name: 'create',
              path: 'create_profile',
              builder: (context, state) => const CreateProfilePage(),
            )
          ]
        ),
      ]
    ),
    ShellRoute(
      builder: (context, state, childWidget) {
        // TODO: Make a bottom navigation bar widget.
        return Container();
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const MarketplacePage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const SettingPage(),
        ),
        GoRoute(
          path: '/storage',
          builder: (context, state) => const StoragePage(),
        ),
        GoRoute(
          path: '/chats',
          builder: (context, state) => const ChatBoxPage(),
        ),
      ]
    )
  ],
);