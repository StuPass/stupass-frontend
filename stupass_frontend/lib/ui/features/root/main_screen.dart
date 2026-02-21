import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stupass_frontend/ui/core/components/navigation_bottomappbar.dart';
import 'package:stupass_frontend/ui/core/theme/app_dimens.dart';
import 'package:stupass_frontend/ui/features/home/presentation/add_post_page.dart';

class MainScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScreen({
    super.key,
    required this.navigationShell,
  });

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The "body" is now the shell itself (which contains the IndexedStack)
      body: navigationShell,
      
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: FloatingActionButton(
          onPressed: () {
            // Keep your modal logic if "Add Post" is a popup, not a tab
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (context) => const AddPostPage()),
            );
          },
          backgroundColor: Colors.green,
          elevation: 0,
          mini: true,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, size: AppDimens.iconDefault),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
      bottomNavigationBar: NavigationBottomAppBar(
        // Use the shell's index, not a local state variable
        currentPageIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
      ),
    );
  }
}