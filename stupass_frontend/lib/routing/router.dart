import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:stupass_frontend/ui/features/account/presentation/setting_page.dart';
import 'package:stupass_frontend/ui/features/auth/presentation/create_profile_page.dart';
import 'package:stupass_frontend/ui/features/auth/presentation/signin_page.dart';
import 'package:stupass_frontend/ui/features/auth/presentation/signup_page.dart';
import 'package:stupass_frontend/ui/features/auth/presentation/verify_via_otp_page.dart';
import 'package:stupass_frontend/ui/features/auth/presentation/welcome_page.dart';
import 'package:stupass_frontend/ui/features/auth/view_models/create_profile_view_model.dart';
import 'package:stupass_frontend/ui/features/auth/view_models/signnup_view_model/signup_view_model.dart';
import 'package:stupass_frontend/ui/features/auth/view_models/verify_via_otp_view_model.dart';
import 'package:stupass_frontend/ui/features/chat/presentation/chat_box_page.dart';
import 'package:stupass_frontend/ui/features/home/presentation/add_post_page.dart';
import 'package:stupass_frontend/ui/features/home/presentation/marketplace_page.dart';
import 'package:stupass_frontend/ui/features/root/main_screen.dart';
import 'package:stupass_frontend/ui/features/storage/presentation/storage.dart';
import 'routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: Routes.signin,
      builder: (context, state) => const SigninPage(),
    ),
    GoRoute(
      path: Routes.signup,
      builder: (context, state) => SignupPage(
        viewModel: SignupViewModel(registrationSession: context.read()),
      ),
      routes: [
        GoRoute(
          name: Routes.verifyOtpName,
          path: Routes.verifyOtpRelative, 
          builder: (context, state) => OtpVerificationPage(
            viewModel: OtpVerificationViewModel(registrationSession: context.read())
          ),
          routes: [
            GoRoute(
              name: Routes.createProfileName,
              path: Routes.createProfileRelative,
              builder: (context, state) => CreateProfilePage(
                viewModel: CreateProfileViewModel(
                    registrationSession: context.read(),
                    authRepository: context.read(),
                  ),
              ),
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
              path: Routes.marketplace,
              builder: (context, state) => const MarketplacePage(),
            ),
          ],
        ),
        // Tab 2: Storage
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.storage,
              builder: (context, state) => const StoragePage(),
            ),
          ],
        ),
        // Tab 3: Add
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.add,
              builder: (context, state) => const AddPostPage(),
            )
          ],
        ),
        // Tab 4: Chat
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.chat,
              builder: (context, state) => const ChatBoxPage(),
            ),
          ],
        ),
        // Tab 5: Settings
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.settings,
              builder: (context, state) => const SettingPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);