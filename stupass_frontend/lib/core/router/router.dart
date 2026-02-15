import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:stupass_frontend/features/account/presentation/setting_page.dart';
import 'package:stupass_frontend/features/auth/presentation/create_profile_page.dart';
import 'package:stupass_frontend/features/auth/presentation/signin_page.dart';
import 'package:stupass_frontend/features/auth/presentation/signup_page.dart';
import 'package:stupass_frontend/features/auth/presentation/verify_via_otp_page.dart';
import 'package:stupass_frontend/features/auth/presentation/welcome_page.dart';
import 'package:stupass_frontend/features/chat/presentation/chat_box_page.dart';
import 'package:stupass_frontend/features/home/presentation/add_post_page.dart';
import 'package:stupass_frontend/features/home/presentation/marketplace_page.dart';
import 'package:stupass_frontend/features/root/main_screen.dart';
import 'package:stupass_frontend/features/storage/presentation/storage.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
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
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        // Tab 1: Marketplace
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/marketplace',
              builder: (context, state) => const MarketplacePage(),
            ),
          ],
        ),
        // Tab 2: Storage
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/storage',
              builder: (context, state) => const StoragePage(),
            ),
          ],
        ),
        // Tab 3: Placeholder for "Add" (Since your FAB handles this, you might not need a route here, 
        // but if it's in the index, we keep it)
        StatefulShellBranch(
          routes: [GoRoute(path: '/add', builder: (context, state) => const AddPostPage())],
        ),
        // Tab 4: Chat
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/chat',
              builder: (context, state) => const ChatBoxPage(),
            ),
          ],
        ),
        // Tab 5: Settings
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

